class EngineordersController < ApplicationController
  before_action :set_engineorder, only: [:show, :edit, :update, :destroy]

  # GET /engineorders
  # GET /engineorders.json
  def index
    @engineorders = Engineorder.all
  end

  # GET /engineorders/1
  # GET /engineorders/1.json
  def show
  end

  # GET /engineorders/new
  def new
    @engineorder = Engineorder.new
  end

  # GET /engineorders/1/edit
  def edit
    #流通ステータスでレンダリング先を変える。
    if @engineorder.isInquiry?
      render :template => "engineorders/inquiry"
    end

    if @engineorder.isShipped?
      render :template => "engineorders/shipped"
    end

    if @engineorder.isShippingreparation?
      render :template => "engineorders/allocated"
    end

    if @engineorder.isOrdered?
      render :template => "engineorders/ordered"
    end
  end

  # POST /engineorders
  # POST /engineorders.json
  def create
    @engineorder = Engineorder.new(engineorder_params)
    #流通ステータスを「引合」にセットする(受注モデルは、引合時に新規作成される)
    @engineorder.setInquiry
    #発行Noを自動採番する
    @engineorder.issue_no = Engineorder.createIssueNo

    respond_to do |format|
      if @engineorder.save
        format.html { redirect_to @engineorder, notice: 'Engineorder was successfully created.' }
        format.json { render action: 'show', status: :created, location: @engineorder }
      else
        format.html { render action: 'new' }
        format.json { render json: @engineorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /engineorders/1
  # PATCH/PUT /engineorders/1.json
  def update
    # 流通ステータスをセットする。(privateメソッド)
    setBusinessstatus
    # エンジンに変更があれば、セットする。
    setEngines

    respond_to do |format|
      if @engineorder.update(engineorder_params)
        # 受注オブジェクトの状況などから、単純な画面項目のセット以外の、各種編集を行う
        self.editByStatus
        format.html { redirect_to @engineorder, notice: 'Engineorder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @engineorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engineorders/1
  # DELETE /engineorders/1.json
  def destroy
    @engineorder.destroy
    respond_to do |format|
      format.html { redirect_to engineorders_url }
      format.json { head :no_content }
    end
  end

  # GET /engineorders/engineInquiry/:engine_id'
  # 引合の処理
  def inquiry
    # パラメータのengine_idをもとに、エンジンオブジェクトを取り出す。
    unless params[:engine_id].nil?
      engine = Engine.find(params[:engine_id])
      @engineorder = engine.current_order_as_old
      if @engineorder.nil?
        @engineorder = Engineorder.new
      end
      @engineorder.setOldEngine(engine)
    else
      @engineorder = Engineorder.new
      @engineorder.setOldEngine(engine)
    end
  end

  # 受注の処理
  def ordered
    set_engineorder
  end

  # 引当の処理
  def allocated
    set_engineorder
  end

  # 出荷の処理
  def shipped
    set_engineorder
  end

  # 返却の処理
  def returning
    set_engineorder
  end

  def editByStatus
    # 今の状態では、引当を複数実施する（引当のやり直し）は出来ないかもしれない
    # 下記は要確認
    # ★整備オブジェクトの発行日とは?
    # ★整備オブジェクトの会社コードは、何になるべき？
    # 

    # 引当画面からの更新の場合
    if params[:commit] == t('views.buttun_allocated')
      # 新エンジンのステータスを出荷準備中に変更する。
      @engineorder.new_engine.setBeforeShipping
      @engineorder.new_engine.save
    end      
  
    # 出荷画面からの更新の場合
    if params[:commit] == t('views.buttun_shipped')
      
      # 新エンジンのステータスを出荷済みにセットする。
      @engineorder.new_engine.setAfterShipping
      
      # 新エンジンの会社を設置先に変更し、DBに反映する
      @engineorder.new_engine.company = @engineorder.install_place
      @engineorder.new_engine.save
      
      # 出荷しようとしている新エンジンに関わる整備オブジェクトを取得する
      repair = @engineorder.repair_for_new_engine
      if !(repair.nil?)
        repair.shipped_date = @engineorder.shipped_date
        repair.save
      end
    end

    # 返却画面からの更新の場合
    if params[:commit] == t('views.buttun_returning')

      repair = @engineorder.repair_for_old_engine
      if repair.nil?
        # 整備オブジェクトを作り、旧エンジンを紐づける。
        repair = @engineorder.createRepair
      else
        # 整備オブジェクトの内容を再編集し、旧エンジンを紐づける。
        @engineorder.modifyRepair	(repair)
      end
      # 旧エンジンのステータスを受領前にセットする。
      @engineorder.old_engine.setBeforeArrive
      
      # DBに格納する。
      repair.save
      @engineorder.old_engine.save
      
    end
  end
  
  
  private
    #流通ステータスをセットする。判定はボタンに表示されているラベルで、どの画面で押されたものかを見て
    #決定している。(ボタンのラベルはprams[:commit]でラベルを取得可能)
    # t('xxxxxx')は、congfg/locales/xxx.ja.ymlから名称を取得するメソッド。
    def setBusinessstatus
      # 引合登録の場合
      if params[:commit] == t('views.buttun_inquiry')
        #流通ステータスを、「受注」にセットする。
        @engineorder.setInquiry
      end
      # 受注登録の場合
      if params[:commit] == t('views.buttun_ordered')
        #流通ステータスを、「受注」にセットする。
        @engineorder.setOrdered
      end
      # 引合登録の場合
      if params[:commit] == t('views.buttun_allocated')
        #流通ステータスを、「出荷準備中」にセットする。
        @engineorder.setShippingreparation
      end
      # 出荷登録の場合
      if params[:commit] == t('views.buttun_shipped')
        #流通ステータスを、「出荷済」にセットする。
        @engineorder.setShipped
      end  
      # 返却登録の場合
      if params[:commit] == t('views.buttun_returning')
        #流通ステータスを、「返却済」にセットする。
        @engineorder.setReturned
      end  
      #paramsに値をセットする(UPDATEで、engineorder_paramsとして更新してもらうため)
      params[:engineorder][:businessstatus_id] = @engineorder.businessstatus_id
    end

    # setEngines
    # パラメータにエンジンIDがあればセットメソッドで先に設定する
    def setEngines
      unless params[:engineorder][:new_engine_id].blank?
        @engineorder.setNewEngine(Engine.find(params[:engineorder][:new_engine_id]))
      end  
      unless params[:engineorder][:old_engine_id].blank?
        @engineorder.setOldEngine(Engine.find(params[:engineorder][:old_engine_id]))
      end  
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_engineorder
      @engineorder = Engineorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engineorder_params
      params.require(:engineorder).permit(:issue_no, :inquiry_date, :registered_user_id, :updated_user_id, :branch_id, :salesman_id, :install_place_id, :orderer, :machine_no, :time_of_running, :change_comment, :order_date, :sending_place_id, :sending_comment, :desirable_delivery_date, :businessstatus_id,
       :new_engine_id, :old_engine_id, :old_engine, :new_engine, :enginestatus_id,:invoice_no_new, :invoice_no_old, :day_of_test, :shipped_date, :returning_date, :returning_comment, :title, :returning_place_id)
    end
end

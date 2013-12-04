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
  end

  # POST /engineorders
  # POST /engineorders.json
  def create
    @engineorder = Engineorder.new(engineorder_params)
    @engineorder.setInquiry
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

  # GET /repairs/engineInquiry/1
  def inquiry
    @engineorder = Engineorder.new
    # パラメータにengine_idがあれば、旧エンジンに紐づける
    if !(params[:engine_id].nil?)
        @engineorder.old_engine = Engine.find(params[:engine_id])
    end
    render :template => "engineorders/new"
   end

  def ordered
    set_engineorder
    @engineorder.setOrdered
    render :template => "engineorders/edit"
  end

  def allocated
    set_engineorder
    @engineorder.setAllocated
    render :template => "engineorders/edit"
  end


  def shipped
    set_engineorder
    @engineorder.setShipped
    render :template => "engineorders/edit"
  end

  def  editByStatus
    # 今の状態では、引当を複数実施する（引当のやり直し）は出来ないかもしれない
    # 下記は要確認
    # ★整備オブジェクトの発行日とは?
    # ★整備オブジェクトの会社コードは、何になるべき？
    # 
    # 出荷画面からの更新の場合
    if !(params[:engineorder][:invoice_no].nil?)
      # 出荷済みの場合は、出荷済みにセットする。
      @engineorder.new_engine.enginestatus_id = 5
      # 新エンジンの会社を設置先に変更する。
      @engineorder.new_engine.company = @engineorder.install_place
      # 新エンジンの情報を更新する。
      @engineorder.new_engine.save
      # 出荷したエンジンに関わる整備オブジェクトがもしあれば、出荷日を設定する
      # エンジンひとつに対して整備オブジェクトは複数ある場合、もっとも大きな値の発行Noのものを対象とする
      repair = Repair.where('engine_id = ?', @engineorder.new_engine_id).order('issue_no desc').first
      if !(repair.nil?)
        repair.shipped_date = @engineorder.shipped_date
        repair.save
      end
    # 引当画面からの更新の場合
    elsif !(params[:engineorder][:new_engine_id].nil?)
      # 引当登録は、新エンジンのステータスを変更する。
      @engineorder.new_engine = Engine.find(params[:engineorder][:new_engine_id])
      @engineorder.new_engine.enginestatus_id = 4
      # 整備オブジェクトを作り、旧エンジンを紐づける。
      @repair = @engineorder.createRepair
      # 整備オブジェクトのエンジン（旧エンジン）のステータスを変更する
      @repair.engine.enginestatus_id = 1
      # 旧エンジンの会社を、（受注の）拠点に変更する。
      @repair.engine.company = @engineorder.branch
      # 画面の返却コメントが入力されていれば、整備オブジェクトの返却コメントにセットする。
      if !(params[:returning_comment].nil?)
        @repair.returning_comment = params[:returning_comment]
      end
      # 新・旧エンジンと整備オブジェクトの情報を更新する。
      @engineorder.old_engine.save
      @engineorder.new_engine.save      
      @repair.save
    end      
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engineorder
      @engineorder = Engineorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engineorder_params
      params.require(:engineorder).permit(:issue_no, :inquiry_date, :registered_user_id, :updated_user_id, :branch_id, :salesman_id, :install_place_id, :orderer, :machine_no, :time_of_running, :change_comment, :order_date, :sending_place_id, :sending_comment, :desirable_delivery_date, :businessstatus_id,
       :new_engine_id, :old_engine_id, :old_engine, :new_engine, :enginestatus_id,:invoice_no, :day_of_test, :shipped_date)
    end
end

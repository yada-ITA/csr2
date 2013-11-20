class EnginesController < ApplicationController
  before_action :set_engine, only: [:show, :edit, :update, :destroy]

  # GET /engines
  # GET /engines.json
  def index
  
    # 1.初期表示（メニューなどからの遷移時）
    #    ログインユーザの会社コードのみを条件に抽出
    #    ①検索条件のクリア
    #    ②ログインユーザの会社コードという条件のみセッションへの保存
    # 2.検索ボタン押下時
    #    画面入力された条件に対して抽出
    #    ①検索条件のクリア
    #    ②画面入力された条件のセッションへの保存
    # 3.ページ繰り時
    #    直前の検索条件をもとにページ繰り
    #    ①検索条件のセッションからの取り出し
    puts '--------------hrer--------------'
    if params[:page].nil?
      # ページ繰り以外
      @searched = Hash.new()
      session[:searched] = @searched
      if params[:commit].nil?
        # 初期表示時：ログインユーザの部門コードという条件のみセッションへの保存
        @searched.store('company_id', current_user.company_id)
      else
        # 検索ボタン押下時：画面入力された条件のセッションへの保存
        params[:search].each do | key, value |
          @searched.store(key, value)
        end
      end
    else
      # ページ繰り時：検索条件のセッションからの取り出し
      @searched = session[:searched]
    end
    # まずはページングを指示
    # @engines = Engine.paginate(:page => params[:page], :order => 'id', :per_page => 3)
    @engines = Engine.all()
    
    # 検索条件が指定されていれば、抽出条件としてwhere句を追加
    # 会社コード（管轄）
    if !(@searched.fetch('company_id', nil).blank?)
      @engines = @engines.where('engines.company_id = ?', @searched.fetch('company_id'))
    end
    # 型式
    if !(@searched.fetch('engineModelName', nil).blank?)
      @engines = @engines.where('engines.engineModelName like ?', "%" + @searched.fetch('engineModelName') + "%")
    end
    # お客様名
    if !(@searched.fetch('salesModelName', nil).blank?)
      @engines = @engines.where('engines.salesModelName like ?', "%" + @searched.fetch('salesModelName') + "%")
    end

  end

  # GET /engines/1
  # GET /engines/1.json
  def show
  end

  # GET /engines/new
  def new
    @engine = Engine.new
  end

  # GET /engines/1/edit
  def edit
  end

  # POST /engines
  # POST /engines.json
  def create
    @engine = Engine.new(engine_params)
    # ステータスを初期設定する。ひとまず５（出荷済）を設定している →画面からの設定とした
    # @engine.enginestatus = Enginestatus.find(5)

    respond_to do |format|
      if @engine.save
        format.html { redirect_to @engine, notice: 'Engine was successfully created.' }
        format.json { render action: 'show', status: :created, location: @engine }
      else
        format.html { render action: 'new' }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /engines/1
  # PATCH/PUT /engines/1.json
  def update
    respond_to do |format|
      if @engine.update(engine_params)
        format.html { redirect_to @engine, notice: 'Engine was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @engine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /engines/1
  # DELETE /engines/1.json
  def destroy
    @engine.destroy
    respond_to do |format|
      format.html { redirect_to engines_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engine
      @engine = Engine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engine_params
      params.require(:engine).permit(:engineModelName, :serialno, :salesModelName, :company_id, :enginestatus_id, :page)
    end
end

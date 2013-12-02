class RepairsController < ApplicationController
  before_action :set_repair, only: [:show, :edit, :update, :destroy]

  # GET /repairs
  # GET /repairs.json
  def index
    @repairs = Repair.all
  end

  # GET /repairs/1
  # GET /repairs/1.json
  def show
  end

  # GET /repairs/new
  def new
    @repair = Repair.new
    # パラメータにengine_idがあり、整備にまだエンジンが紐づけられていなければ、エンジンを紐づける
    if !(params[:engine_id].nil?)
      if @repair.engine.nil?
        @repair.engine = Engine.find(params[:engine_id])
      end
    end
  end

  # GET /repairs/1/edit
  def edit
  end

  # POST /repairs
  # POST /repairs.json
  def create
    # パラメータにエンジンIDがある場合、まずエンジンに、作業中の整備オブジェクトの取得を試みる
    engine = Engine.find(params[:repair][:engine_id])
    @reapir = engine.current_repair
    # 作業中の整備オブジェクトが存在しない場合、整備オブジェクトを作って、当該のエンジンに紐づける
    if @reapir.nil?
      @repair = Repair.new(repair_params)  
	    if !(params[:repair][:engine_id].nil?)
        @repair.engine = engine
	    end   
    end
    # パラメータにenginestatus_idがあれば、エンジンのステータスを設定し、所轄をログインユーザの会社に変更する
    if !(params[:enginestatus_id].nil?)
      @repair.engine.enginestatus = Enginestatus.find(params[:enginestatus_id].to_i)
      @repair.engine.company = current_user.company
      @repair.engine.save     
    end
    respond_to do |format|
      if @repair.save
        format.html { redirect_to @repair, notice: 'Repair was successfully created.' }
        format.json { render action: 'show', status: :created, location: @repair }
      else
        format.html { render action: 'new' }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repairs/1
  # PATCH/PUT /repairs/1.json
  def update
    respond_to do |format|
      if @repair.update(repair_params)
        # パラメータにenginestatus_idがあれば、エンジンのステータスを設定し、所轄をログインユーザの会社に変更する
		    if !(params[:enginestatus_id].nil?)
		      @repair.engine.enginestatus = Enginestatus.find(params[:enginestatus_id].to_i)
          @repair.engine.company = current_user.company
		      @repair.engine.save
		    end
        format.html { redirect_to @repair, notice: 'Repair was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repairs/1
  # DELETE /repairs/1.json
  def destroy
    @repair.destroy
    respond_to do |format|
      format.html { redirect_to repairs_url }
      format.json { head :no_content }
    end
  end

  # GET /repairs/engineArrived/1
  def engineArrived
    # パラメータにエンジンIDがある場合、まずエンジンに、作業中の整備オブジェクトの取得を試みる
    engine = Engine.find(params[:engine_id])
    @repair = engine.current_repair
    # 作業中の整備オブジェクトが存在しない場合、整備オブジェクトを作って、当該のエンジンに紐づける
    if @repair.nil?
      @repair = Repair.new()  
	    if !(params[:engine_id].nil?)
        @repair.engine = engine
	    end   
    end
  end

  # GET /repairs/repairStarted/1
  def repairStarted
    set_repair
  end

  # GET /repairs/repairFinished/1
  def repairFinished
    set_repair
  end
  
  # GET /repairs/repairOrder/1  
  def repairOrder
    set_repair
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair
      @repair = Repair.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repair_params
      params.require(:repair).permit(:id, :issue_no, :issue_date, :arrive_date, :start_date, :finish_date, :before_comment, :after_comment, :time_of_running, :day_of_test, :returning_comment, :arrival_comment, :order_no, :order_date, :construction_no, :desirable_finish_date, :estimated_finish_date, :engine_id, :enginestatus_id)
    end
end

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
    # パラメータにengine_idがあれば、エンジンを設定する
    if !(params[:engine_id].nil?)
      @repair.engine = Engine.find(params[:engine_id])
    end
  end

  # GET /repairs/1/edit
  def edit
  end

  # POST /repairs
  # POST /repairs.json
  def create
    @repair = Repair.new(repair_params)
    # パラメータにenginestatus_idがあれば、エンジンのステータスを設定する
    if !(params[:enginestatus_id].nil?)
      @repair.engine.enginestatus = Enginestatus.find(params[:enginestatus_id].to_i)
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
		    # パラメータにenginestatus_idがあれば、エンジンのステータスを設定する
		    if !(params[:enginestatus_id].nil?)
		      @repair.engine.enginestatus = Enginestatus.find(params[:enginestatus_id].to_i)
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
  
  def engineArrived
    @repair = Repair.new
    # パラメータにengine_idがあれば、エンジンを設定する
    if !(params[:engine_id].nil?)
      @repair.engine = Engine.find(params[:engine_id])
    end
  end
  def repairStarted
    @repair = Repair.find(params[:id])
  end

  def repairFinished
    @repair = Repair.find(params[:id])
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repair
      @repair = Repair.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repair_params
      params.require(:repair).permit(:id, :issueNo, :issueDate, :arriveDate, :startDate, :finishDate, :beforeComment, :afterComment, :engine_id, :enginestatus_id)
    end
end

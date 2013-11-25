class RepairordersController < ApplicationController
  before_action :set_repairorder, only: [:show, :edit, :update, :destroy]

  # GET /repairorders
  # GET /repairorders.json
  def index
    @repairorders = Repairorder.all
  end

  # GET /repairorders/1
  # GET /repairorders/1.json
  def show
  end

  # GET /repairorders/new
  def new
    @repairorder = Repairorder.new
    # パラメータにengine_idがあれば、エンジンを設定する
    if !(params[:engine_id].nil?)
      @repairorder.engine = Engine.find(params[:engine_id])
    end
  end

  # GET /repairorders/1/edit
  def edit
  end

  # POST /repairorders
  # POST /repairorders.json
  def create
    @repairorder = Repairorder.new(repairorder_params)
    # パラメータにenginestatus_idがあれば、エンジンのステータスを設定する
    if !(params[:enginestatus_id].nil?)
      @repairorder.engine.enginestatus = Enginestatus.find(params[:enginestatus_id].to_i)
      @repairorder.engine.save
    end
  
    #発行Noはここで自動採番
    @repairorder.issueNo = Repairorder.createIssueNo

    respond_to do |format|
      if @repairorder.save
        format.html { redirect_to @repairorder, notice: 'Repairorder was successfully created.' }
        format.json { render action: 'show', status: :created, location: @repairorder }
      else
        format.html { render action: 'new' }
        format.json { render json: @repairorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repairorders/1
  # PATCH/PUT /repairorders/1.json
  def update
    respond_to do |format|
      if @repairorder.update(repairorder_params)
		    # パラメータにenginestatus_idがあれば、エンジンのステータスを設定する
		    if !(params[:enginestatus_id].nil?)
		      @repairorder.engine.enginestatus = Enginestatus.find(params[:enginestatus_id].to_i)
		      @repairorder.engine.save
		    end
        format.html { redirect_to @repairorder, notice: 'Repairorder was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @repairorder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repairorders/1
  # DELETE /repairorders/1.json
  def destroy
    @repairorder.destroy
    respond_to do |format|
      format.html { redirect_to repairorders_url }
      format.json { head :no_content }
    end
  end
  
  # GET /repairorders/engineReturning/1
  def engineReturning
    @repairorder = Repairorder.new
    # パラメータにengine_idがあれば、エンジンを設定する
    if !(params[:engine_id].nil?)
      @repairorder.engine = Engine.find(params[:engine_id])
    end
  end

  # GET /repairorders/repairOrdered/1
  def repairOrdered
    @repairorder = Repairorder.find(params[:id])
  end

  # GET /repairorders/repairAccepted/1
  def repairAccepted
    @repairorder = Repairorder.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repairorder
      @repairorder = Repairorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repairorder_params
      params.require(:repairorder).permit(:issueNo, :issueDate, :orderNo, :constructionNo, :otherBrandPartsArrivealDate, :returnDate, :returningComment, :sendingComment, :engine_id, :enginestatus_id)
    end
end

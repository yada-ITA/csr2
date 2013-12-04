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
    if !(params[:engineorder][:invoice_no].nil?)
      #出荷済みの場合は、出荷済みにセットする。
      @engineorder.new_engine.enginestatus_id = 5
      #新エンジンの情報を更新する。
      @engineorder.new_engine.save
    elsif !(params[:engineorder][:new_engine_id].nil?)
      #引当登録は、新・旧エンジンのステータスを変更する。
      @engineorder.old_engine.enginestatus_id = 1
      @engineorder.new_engine = Engine.find(params[:engineorder][:new_engine_id])
      @engineorder.new_engine.enginestatus_id = 4
      #新・旧エンジンの情報を更新する。
      @engineorder.old_engine.save
      @engineorder.new_engine.save
    end
    respond_to do |format|
      if @engineorder.update(engineorder_params)
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_engineorder
      @engineorder = Engineorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def engineorder_params
      params.require(:engineorder).permit(:issue_no, :inquiry_date, :registered_user_id, :updated_user_id, :branch_id, :salesman_id, :install_place_id, :orderer, :machine_no, :time_of_running, :change_comment, :order_date, :sending_place_id, :sending_comment, :desirable_delivery_date, :businessstatus_id,
       :new_engine_id, :old_engine_id, :old_engine, :new_engine, :enginestatus_id,:invoice_no)
    end
end

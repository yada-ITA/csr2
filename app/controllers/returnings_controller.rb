class ReturningsController < ApplicationController
  before_action :set_returning, only: [:show, :edit, :update, :destroy]

  # GET /returnings
  # GET /returnings.json
  def index
    @returnings = Returning.all
  end

  # GET /returnings/1
  # GET /returnings/1.json
  def show
  end

  # GET /returnings/new
  def new
    @returning = Returning.new
  end

  # GET /returnings/1/edit
  def edit
  end

  # POST /returnings
  # POST /returnings.json
  def create
    @returning = Returning.new(returning_params)

    respond_to do |format|
      if @returning.save
        format.html { redirect_to @returning, notice: 'Returning was successfully created.' }
        format.json { render action: 'show', status: :created, location: @returning }
      else
        format.html { render action: 'new' }
        format.json { render json: @returning.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /returnings/1
  # PATCH/PUT /returnings/1.json
  def update
    respond_to do |format|
      if @returning.update(returning_params)
        format.html { redirect_to @returning, notice: 'Returning was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @returning.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /returnings/1
  # DELETE /returnings/1.json
  def destroy
    @returning.destroy
    respond_to do |format|
      format.html { redirect_to returnings_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_returning
      @returning = Returning.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def returning_params
      params.require(:returning).permit(:returnDate, :returningComment, :sendingComment)
    end
end

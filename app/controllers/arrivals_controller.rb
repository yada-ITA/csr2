class ArrivalsController < ApplicationController
  before_action :set_arrival, only: [:show, :edit, :update, :destroy]

  # GET /arrivals
  # GET /arrivals.json
  def index
    @arrivals = Arrival.all
  end

  # GET /arrivals/1
  # GET /arrivals/1.json
  def show
  end

  # GET /arrivals/new
  def new
    @arrival = Arrival.new
  end

  # GET /arrivals/1/edit
  def edit
  end

  # POST /arrivals
  # POST /arrivals.json
  def create
    @arrival = Arrival.new(arrival_params)

    respond_to do |format|
      if @arrival.save
        format.html { redirect_to @arrival, notice: 'Arrival was successfully created.' }
        format.json { render action: 'show', status: :created, location: @arrival }
      else
        format.html { render action: 'new' }
        format.json { render json: @arrival.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /arrivals/1
  # PATCH/PUT /arrivals/1.json
  def update
    respond_to do |format|
      if @arrival.update(arrival_params)
        format.html { redirect_to @arrival, notice: 'Arrival was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @arrival.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /arrivals/1
  # DELETE /arrivals/1.json
  def destroy
    @arrival.destroy
    respond_to do |format|
      format.html { redirect_to arrivals_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arrival
      @arrival = Arrival.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def arrival_params
      params.require(:arrival).permit(:arrivalDate, :arrivalComment)
    end
end

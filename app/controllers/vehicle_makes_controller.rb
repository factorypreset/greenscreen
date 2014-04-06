class VehicleMakesController < ApplicationController

  # GET /vehicle_makes.json
  def index
    @vehicle_makes = VehicleMake.all

    respond_to do |format|
      format.html
      format.json { render json: @vehicle_makes }
    end
  end

  # GET /vehicle_makes/:id.json
  def show
    @vehicle_make = VehicleMake.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @vehicle_make }
    end
  end

end

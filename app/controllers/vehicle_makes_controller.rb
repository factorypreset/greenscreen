class VehicleMakesController < ApplicationController

  # GET /vehicle_makes.json
  def index
    @vehicle_makes = VehicleMake.all.order("make")
    respond_to do |format|
      format.json { render json: @vehicle_makes }
      format.any
    end 
  end

  # GET /vehicle_makes/:id.json
  # GET /vehicle_makes/:id
  def show
    @vehicle_make = VehicleMake.find(params[:id])
    respond_to do |format|
      format.json { render json: @vehicle_make }
      format.any
    end
  end

end

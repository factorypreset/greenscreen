class VehicleMakesController < ApplicationController

  respond_to :json

  # GET /vehicle_makes.json
  def index
    @vehicle_makes = VehicleMake.all
    respond_with(@vehicle_makes)
  end

  # GET /vehicle_makes/:id.json
  def show
    @vehicle_make = VehicleMake.find(params[:id])
    respond_with(@vehicle_make)
  end

end

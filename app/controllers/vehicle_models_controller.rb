class VehicleModelsController < ApplicationController

  # GET /vehicle-makes/:vehicle_make_id/vehicle-models.json
  def index
    @vehicle_make = VehicleMake.find(vehicle_params[:vehicle_make_id])
    @vehicle_models = find_vehicle_models
    respond_to do |format|
      format.json { render json: @vehicle_models }
      format.any
    end
  end

  # GET /vehicle-makes/:vehicle_make_id/vehicle-models/:id.json
  def show
    @vehicle_model = VehicleModel.find(params[:id])
    respond_to do |format|
      format.json { render json: @vehicle_model }
      format.any
    end
  end

  private

  def vehicle_params
    params.permit(:year, :make, :vehicle_make_id)
  end

  def find_vehicle_models
    VehicleModel
      .by_vehicle_make_id(vehicle_params[:vehicle_make_id])
      .by_year(vehicle_params[:year])
      .by_make(vehicle_params[:make])
      .dedupe_name
      .limit(2000)
  end

end

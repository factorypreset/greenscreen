class VehicleModelsController < ApplicationController

  respond_to :json

  # GET /vehicle_models.json
  def index
    @vehicle_models = find_vehicle_models
    respond_with(@vehicle_models)
  end

  # GET /vehicle_models/:id.json
  def show
    @vehicle_model = VehicleModel.find(params[:id])
    respond_with(@vehicle_model)
  end

  private

  def vehicle_params
    params.permit(:year, :make)
  end

  def find_vehicle_models
    # VehicleModel.by_year(vehicle_params[:year]).by_make(vehicle_params[:make])
    #VehicleModel.by_year(vehicle_params[:year]).by_make(vehicle_params[:make]).dedupe_name.order("vehicle_makes.make, model").limit(2000)
    VehicleModel.by_year(vehicle_params[:year]).by_make(vehicle_params[:make]).dedupe_name.limit(2000)
    #VehicleModel.by_year(vehicle_params[:year]).by_make(vehicle_params[:make]).limit(2000)
  end

end

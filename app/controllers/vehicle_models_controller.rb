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
    VehicleModel.by_year(vehicle_params[:year]).by_make(vehicle_params[:make])
  end

end

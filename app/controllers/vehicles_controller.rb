class VehiclesController < ApplicationController

  respond_to :json

  def index
    @vehicle_models = find_vehicle_models
    respond_with(@vehicle_models)
  end

  def show
    @vehicle_model = VehicleModel.find(params[:id])
    respond_with(@vehicle_model)
  end

  private

  def vehicle_params
    params.permit(:year, :make)
  end

  def find_vehicle_models
    if vehicle_params.any?
      return VehicleModel.by_year(vehicle_params[:year]).by_make(vehicle_params[:make])
    else
      return VehicleModel.all
    end
  end

end

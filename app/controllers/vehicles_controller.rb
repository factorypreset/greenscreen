class VehiclesController < ApplicationController

  respond_to :json

  def index
    if params.has_key?(:year) and params.has_key?(:make)
      @vehicle_models = VehicleModel.by_year(params[:year]).by_make(params[:make])
    elsif params.has_key?(:year)
      @vehicle_models = VehicleModel.by_year(params[:year])
    elsif params.has_key?(:make)
      @vehicle_models = VehicleModel.by_make(params[:make])
    else
      @vehicle_models = VehicleModel.all
    end

    respond_with(@vehicle_models)
  end

  def show
    @vehicle_model = VehicleModel.find(params[:id])
    respond_with(@vehicle_model)
  end

  

end

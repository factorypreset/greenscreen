class VehicleMakesController < ApplicationController

  # GET /vehicle_makes.json
  def index
    @vehicle_makes = VehicleMake.all.order("make")
    respond_to do |format|
      format.json { render json: @vehicle_makes }
      format.any
    end 
  end

  # GET /vehicle_makes/statistics.json
  # GET /vehicle_makes/statistics
  def index_statistics
    @vehicle_statistics = VehicleMake.averages_by_year([
      :city_mpg,
      :hwy_mpg,
      :combined_mpg,
      :air_pollution_score,
      :greenhouse_gas_score
    ])
    respond_to do |format|
      format.json { render json: @vehicle_statistics }
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

  # GET /vehicle_makes/:id/statistics.json
  # GET /vehicle_makes/:id/statistics
  def statistics
    vehicle_make = VehicleMake.find(params[:id])
    @vehicle_statistics = vehicle_make.averages_by_year([
      :city_mpg,
      :hwy_mpg,
      :combined_mpg,
      :air_pollution_score,
      :greenhouse_gas_score
    ])
    respond_to do |format|
      format.json { render json: @vehicle_statistics }
      format.any
    end
  end

end

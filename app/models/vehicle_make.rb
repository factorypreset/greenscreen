class VehicleMake < ActiveRecord::Base
  has_many :vehicle_models

  def average_for_year(column, year)
    VehicleModel.where(:vehicle_make_id => id).where(:model_year => year).average(column)
  end

  def average_by_year(column)
    VehicleModel.where(:vehicle_make_id => id).group(:model_year).average(column)
  end
end

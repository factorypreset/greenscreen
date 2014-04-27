class VehicleMake < ActiveRecord::Base
  has_many :vehicle_models

  def average_combined_mpg_for_year(year)
    VehicleModel.where(:vehicle_make_id => id).where(:model_year => year).average(:combined_mpg)
  end

  def average_city_mpg_for_year(year)
    VehicleModel.where(:vehicle_make_id => id).where(:model_year => year).average(:city_mpg)
  end

  def average_combined_mpg_by_year
    VehicleModel.where(:vehicle_make_id => id).group(:model_year).average(:combined_mpg)
  end

  def average_city_mpg_by_year
    VehicleModel.where(:vehicle_make_id => id).group(:model_year).average(:city_mpg)
  end
end

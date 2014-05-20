class VehicleMake < ActiveRecord::Base
  has_many :vehicle_models

  def average_for_year(column, year)
    VehicleModel.where(:vehicle_make_id => id).where(:model_year => year).average(column)
  end

  def average_by_year(column)
    VehicleModel.where(:vehicle_make_id => id).group(:model_year).average(column)
  end

  def averages_for_year(columns, year)
    averages = {}
    columns.each{ |column| averages[column] = average_for_year(column, year) }
    averages
  end

  def averages_by_year(columns)
    averages = {}
    columns.each{ |column| averages[column] = average_by_year(column) }
    averages
  end

  def self.average_by_year(column)
    VehicleModel.group(:model_year).average(column)
  end

  def self.averages_by_year(columns)
    averages = {}
    columns.each{ |column| averages[column] = average_by_year(column) }
    averages
  end
end

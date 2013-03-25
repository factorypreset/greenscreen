class VehicleModel < ActiveRecord::Base
  attr_protected :id

  belongs_to :vehicle_make
  belongs_to :vehicle_class

  def self.by_year(year)
    where(:model_year => year)
  end

  def self.by_make(make)
    joins(:vehicle_make).where("vehicle_makes.make = ?", make.upcase) 
  end

  def full_name
    return "#{vehicle_make.make} #{model}"
  end

end

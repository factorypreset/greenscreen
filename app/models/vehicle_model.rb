class VehicleModel < ActiveRecord::Base
  belongs_to :vehicle_make
  belongs_to :vehicle_class

  def self.by_year(year)
    if year.blank?
      all
    else
      where(:model_year => year)
    end
  end

  def self.by_make(make)
    if make.blank?
      all
    else
      joins(:vehicle_make).where("vehicle_makes.make = ?", make.upcase)
    end
  end

  def self.dedupe_name
    select("DISTINCT model")
  end

  def full_name
    "#{vehicle_make.make} #{model}"
  end

end

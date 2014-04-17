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

  def self.by_vehicle_make_id(make_id)
    if make_id.blank?
      all.order("model, model_year")
    else
      where("vehicle_make_id = ?", make_id)
    end
  end

  def self.by_make(make)
    if make.blank?
      all.order("model, model_year")
    else
      joins(:vehicle_make).where("vehicle_makes.make = ?", make.upcase).order("vehicle_makes.make, model, model_year")
    end
  end

  def self.dedupe_name
    #select(:model).distinct
    group(:model)
  end

  def full_name
    "#{vehicle_make.make} #{model}"
  end

end

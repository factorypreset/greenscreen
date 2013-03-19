class VehicleMake < ActiveRecord::Base
  attr_accessible :make

  has_many :vehicle_models

end

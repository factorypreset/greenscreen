class VehicleClass < ActiveRecord::Base
  attr_accessible :class

  has_many :vehicle_models

end

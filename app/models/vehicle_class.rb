class VehicleClass < ActiveRecord::Base
  attr_accessible :vehicle_class

  has_many :vehicle_models

end

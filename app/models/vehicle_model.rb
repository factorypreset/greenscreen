class VehicleModel < ActiveRecord::Base
  attr_protected :id

  belongs_to :vehicle_make
  belongs_to :vehicle_class
end

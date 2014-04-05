require 'test_helper'

describe VehicleClass do

  let(:vehicle_class) {
    create :vehicle_class, 
           vehicle_class: "A test vehicle class",
           source: "EPA"
  }

  it "has the correct properties" do
    vehicle_class.must_respond_to :vehicle_class
    vehicle_class.must_respond_to :source
  end

end

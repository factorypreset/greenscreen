require 'test_helper'

describe VehicleMake do

  let(:vehicle_make) {
    create :vehicle_make, 
           make: "A Manufacturer"
  }

  it "has the correct properties" do
    vehicle_make.must_respond_to :make
    vehicle_make.must_respond_to :source
  end

end

require 'test_helper'

describe VehicleModel do

  describe "properties" do
    let(:vm) { create :vehicle_model }

    it "has the correct properties" do
      vm.must_respond_to :model
      vm.must_respond_to :vehicle_class
      vm.must_respond_to :vehicle_make
    end
  end

  describe "scopes" do

    before :each do
      @v1 = create :vehicle_model, model_year: '2012'
      @v2 = create :vehicle_model, model_year: '2011'
    end

    it "can find all the vehicles" do
      VehicleModel.all.count.must_equal 2
    end

    it "can find vehicles made in a given year" do
      VehicleModel.by_year('2012').count.must_equal 1
    end

    it "can find vehicles made by a given manufacturer" do
      @v1.vehicle_make = create :vehicle_make, make: 'HONDA'
      @v2.vehicle_make = create :vehicle_make, make: 'AUDI'
      @v1.save
      @v2.save

      VehicleModel.by_make('Honda').count.must_equal 1
    end

  end
end

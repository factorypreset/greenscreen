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
      @v1 = create :vehicle_model, model: "FakeModel1", model_year: "2012"
      @v2 = create :vehicle_model, model: "FakeModel2", model_year: "2011"
    end

    it "can find all the vehicles" do
      VehicleModel.all.length.must_equal 2
    end

    it "can find vehicles made in a given year" do
      VehicleModel.by_year('2012').length.must_equal 1
    end

    it "can find vehicles made by a given manufacturer" do
      @v1.vehicle_make = create :vehicle_make, make: 'HONDA'
      @v2.vehicle_make = create :vehicle_make, make: 'AUDI'
      @v1.save
      @v2.save

      VehicleModel.by_make('Honda').length.must_equal 1
    end

    it "can exclude duplicate model names" do
      @v2.model = @v1.model
      @v2.save

      VehicleModel.dedupe_name.length.must_equal 1
    end

    it "can exclude duplicates of the same make and model" do
      @v1.vehicle_make = create :vehicle_make, make: 'HONDA'
      @v3 = create :vehicle_model,
                   model: @v1.model,
                   model_year: @v1.model_year,
                   vehicle_make: @v1.vehicle_make
      @v4 = create :vehicle_model,
                   model: @v1.model,
                   model_year: @v1.model_year
      @v4.vehicle_make = create :vehicle_make, make: 'TOYOTA'
      @v1.save
      @v3.save
      @v4.save

      # check test data is set up correctly
      VehicleModel.by_make('Honda').length.must_equal 2

      # validate chaining by_make and dedupe_name scopes
      VehicleModel.by_make('Honda').dedupe_name.length.must_equal 1
    end

  end

  describe "methods" do

    it "should return the correct full name for a vehicle model" do
      vehicle = create :vehicle_model, model: "FakeModel"
      vehicle.vehicle_make = create :vehicle_make, make: "FAKEMAKE"
      vehicle.save

      vehicle.full_name.must_equal "FAKEMAKE FakeModel"
    end
  end
end

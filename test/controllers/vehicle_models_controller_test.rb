require 'test_helper'
require 'json'

describe VehicleModelsController do

  describe :index do

    before :each do
      @m1 = create :vehicle_make, make: 'CHEVROLET'
      @m2 = create :vehicle_make, make: 'TESLA'

      @v1 = create :vehicle_model, model_year: '2012', model: 'FirstCar'
      @v1.vehicle_make = @m1
      @v1.save

      @v2 = create :vehicle_model, model_year: '2010', model: 'SecondCar'
      @v2.vehicle_make = @m2
      @v2.save

      @v3 = create :vehicle_model, model_year: '2013', model: 'ThirdCar'
      @v3.vehicle_make = @m1
      @v3.save
    end

    it "can list of all vehicles for a given make" do
      get :index, format: 'json', vehicle_make_id: @m1.id
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 2
    end

    it "can get all vehicle models for a given make in a given year" do
      get :index, format: 'json', vehicle_make_id: @m1.id, year: '2012'
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 1
      result.first['model_year'].to_s.must_equal '2012'
    end

  end

  describe "show" do

    before :each do
      @v1 = create :vehicle_model, model_year: '2012'
      @v1.vehicle_make = create :vehicle_make, make: 'CHEVROLET'
      @v1.save

      @v2 = create :vehicle_model, model_year: '2010'
      @v2.vehicle_make = create :vehicle_make, make: 'TESLA'
      @v2.save
    end

    it "can show a single vehicle model" do
      get :show, format: 'json', vehicle_make_id: @v1.vehicle_make.id, id: @v1.id
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result['id'].must_equal @v1.id
      result['model'].must_equal @v1.model
    end

  end
end

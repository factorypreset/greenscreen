require 'test_helper'
require 'json'

describe VehiclesController do

  describe :index do

    before :each do
      @v1 = create :vehicle_model, model_year: '2012'
      @v2 = create :vehicle_model, model_year: '2010'
    end

    it "can list of all vehicles" do
      get :index, format: 'json'
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 2
    end

    it "can get all vehicles in a given year" do
      get :index, format: 'json', year: '2010'
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 1
      result.first['model_year'].to_s.must_equal '2010'
    end

    it "can get all vehicles of a given make" do
      @v1.vehicle_make = create :vehicle_make, make: 'CHEVROLET'
      @v2.vehicle_make = create :vehicle_make, make: 'TESLA'
      @v1.save
      @v2.save

      get :index, format: 'json', make: 'Tesla'
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 1
      result.first['vehicle_make_id'].must_equal @v2.vehicle_make_id
    end

  end
end

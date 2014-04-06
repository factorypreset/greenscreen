require 'test_helper'
require 'json'

describe VehiclesController do

  describe :index do

    before :each do
      @v1 = create :vehicle_model, model_year: '2012'
      @v1.vehicle_make = create :vehicle_make, make: 'CHEVROLET'
      @v1.save

      @v2 = create :vehicle_model, model_year: '2010'
      @v2.vehicle_make = create :vehicle_make, make: 'TESLA'
      @v2.save
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
      get :index, format: 'json', make: 'Tesla'
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 1
      result.first['vehicle_make_id'].must_equal @v2.vehicle_make_id
    end

    it "can get all vehicles of a given make from a given year" do
      v3 = create :vehicle_model, model_year: '2012'
      v3.vehicle_make = @v1.vehicle_make
      v3.save

      v4 = create :vehicle_model, model_year: '2009'
      v4.vehicle_make = @v1.vehicle_make
      v4.save

      get :index, format: 'json', make: 'Chevrolet', year: '2012'
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 2
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
      get :show, format: 'json', id: @v1.id
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result['id'].must_equal @v1.id
      result['model'].must_equal @v1.model
    end

  end
end

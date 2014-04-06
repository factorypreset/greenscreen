require 'test_helper'
require 'json'

describe VehicleMakesController do
  
  describe :index do

    before :each do
      @make = create :vehicle_make, make: "HUMMER"
    end

    it "can get all the vehicle makes" do
      get :index, format: 'json'
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result.count.must_equal 1
      result.first['make'].must_equal "HUMMER"
    end
  end

  describe :show do

    before :each do
      @make = create :vehicle_make, make: "NISSAN"
    end

    it "can get a single vehicle make" do
      get :show, format: 'json', id: @make.id
      response.success?.must_equal true

      result = JSON.parse(response.body)
      result['make'].must_equal "NISSAN"
    end
  end
end
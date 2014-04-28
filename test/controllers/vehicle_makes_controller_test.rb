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

  describe :statistics do

    before :each do
      @make = create :vehicle_make, make: "TOYOTA"
      @model = create :vehicle_model,
                      model: "Prius",
                      model_year: "2013",
                      city_mpg: 30,
                      hwy_mpg: 50,
                      combined_mpg: 40,
                      air_pollution_score: 6,
                      greenhouse_gas_score: 7,
                      vehicle_make_id: @make.id

      get :statistics, format: 'json', id: @make.id
      response.success?.must_equal true
      @result = JSON.parse(response.body)
    end

    it "returns a full set of statistics for a given vehicle make" do
      @result.has_key?('city_mpg').must_equal true
      @result.has_key?('hwy_mpg').must_equal true
      @result.has_key?('combined_mpg').must_equal true
      @result.has_key?('air_pollution_score').must_equal true
      @result.has_key?('greenhouse_gas_score').must_equal true
    end

    it "only returns valid statistics" do
      @result.has_key?('non_existent_statistic').must_equal false
    end

    it "can get correct average value for one field" do
      @result['combined_mpg']['2013'].to_i.must_equal 40
    end
  end
end

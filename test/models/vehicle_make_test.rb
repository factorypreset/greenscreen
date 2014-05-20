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

  describe "statistics" do

    before :each do
      vehicle_model1 = create :vehicle_model,
                              model: "First Model",
                              model_year: "2013",
                              vehicle_make_id: vehicle_make.id,
                              combined_mpg: 10,
                              city_mpg: 8,
                              hwy_mpg: 12

      vehicle_model2 = create :vehicle_model,
                              model: "Second Model",
                              model_year: "2013",
                              vehicle_make_id: vehicle_make.id,
                              combined_mpg: 30,
                              city_mpg: 20,
                              hwy_mpg: 40

      vehicle_model3 = create :vehicle_model,
                              model: "Third Model",
                              model_year: "2014",
                              vehicle_make_id: vehicle_make.id,
                              combined_mpg: 100,
                              city_mpg: 80,
                              hwy_mpg: 120

      vehicle_model1.save!
      vehicle_model2.save!
      vehicle_model3.save!
    end

    it "can calculate average combined mpg for a single year" do
      avg = vehicle_make.average_for_year(:combined_mpg, "2014")
      avg.to_i.must_equal 100
    end

    it "can calculate average combined mpg for two vehicles in the same year" do
      avg = vehicle_make.average_for_year(:combined_mpg, "2013")
      avg.to_i.must_equal 20
    end

    it "can calculate average combined mpg across years" do
      avg = vehicle_make.average_by_year(:combined_mpg)
      avg[2013].to_i.must_equal 20
      avg[2014].to_i.must_equal 100
    end

    it "can calculate average city mpg for a single year" do
      avg = vehicle_make.average_for_year(:city_mpg, "2014")
      avg.to_i.must_equal 80
    end

    it "can calculate average city mpg for two vehicles in the same year" do
      avg = vehicle_make.average_for_year(:city_mpg, "2013")
      avg.to_i.must_equal 14
    end

    it "can calculate average city mpg across years" do
      avg = vehicle_make.average_by_year(:city_mpg)
      avg[2013].to_i.must_equal 14
      avg[2014].to_i.must_equal 80
    end

    it "can aggregate statistics for a single year" do
      avg = vehicle_make.averages_for_year(
        [:city_mpg, :hwy_mpg, :combined_mpg],
        "2014"
      )
      avg[:city_mpg].to_i.must_equal 80
      avg[:combined_mpg].to_i.must_equal 100
      avg[:hwy_mpg].to_i.must_equal 120
    end

    it "can aggregate statistics across years" do
      avg = vehicle_make.averages_by_year([:city_mpg, :hwy_mpg, :combined_mpg])
      avg[:city_mpg][2014].to_i.must_equal 80
      avg[:city_mpg][2013].to_i.must_equal 14
      avg[:combined_mpg][2014].to_i.must_equal 100
      avg[:hwy_mpg][2014].to_i.must_equal 120
    end
  end

  describe "statistics for all vehicle makes" do

    let(:vehicle_make2) {
      create :vehicle_make,
             make: "A Second Manufacturer"
    }

    before :each do
      vehicle_model1 = create :vehicle_model,
                              model: "First Model",
                              model_year: "2013",
                              vehicle_make_id: vehicle_make.id,
                              combined_mpg: 10,
                              city_mpg: 8,
                              hwy_mpg: 12

      vehicle_model2 = create :vehicle_model,
                              model: "Second Model",
                              model_year: "2013",
                              vehicle_make_id: vehicle_make2.id,
                              combined_mpg: 30,
                              city_mpg: 20,
                              hwy_mpg: 40

      vehicle_model1.save!
      vehicle_model2.save!
    end

    it "can aggregate statistics for all makes" do
      avg = VehicleMake.averages_by_year([:city_mpg, :hwy_mpg, :combined_mpg])
      avg[:city_mpg][2013].to_i.must_equal 14
      avg[:combined_mpg][2013].to_i.must_equal 20
      avg[:hwy_mpg][2013].to_i.must_equal 26
    end

  end

end

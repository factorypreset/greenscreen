require 'test_helper'

describe ImportHelpers::EPA::Vehicles do
  
  before :each do
    @subject = ImportHelpers::EPA::Vehicles

    # load a dummy file
    # contains 2 Aston Martins and 3 Teslas
    @csv = @subject.csv_load('dummy.txt')
  end

  it "can load a csv file" do
    @csv.count.must_equal 5
    @csv.first["Model"].must_equal "ASTON MARTIN DB9"
  end

  it "can correctly identify a make containing multiple words" do
    result = @subject.is_multiword_make?('LAND ROVER')
    result.must_equal true
  end

  it "can correctly identify a single-word make" do
    result = @subject.is_multiword_make?('FORD')
    result.must_equal false
  end

  it "can split make from model" do
    result = @subject.parse_make_and_model('CHEVROLET Volt')
    result[:make].must_equal 'CHEVROLET'
    result[:model].must_equal 'Volt'
  end

  it "can split make from model for multiword makes too" do
    result = @subject.parse_make_and_model('LAND ROVER Range Rover')
    result[:make].must_equal 'LAND ROVER'
    result[:model].must_equal 'Range Rover'
  end

  it "converts yes and no to true and false" do
    @subject.to_boolean('yes').must_equal true
    @subject.to_boolean('no').must_equal false
  end

  it "can map vehicle make fields" do
    row = @csv.first
    mapping = @subject.map_vehicle_make_fields(row)
    mapping[:make].must_equal 'ASTON MARTIN'
    mapping[:source].must_equal 'EPA'
  end

  it "can map vehicle class fields" do
    row = @csv.first
    mapping = @subject.map_vehicle_class_fields(row)
    mapping[:vehicle_class].must_equal 'small car'
    mapping[:source].must_equal 'EPA'
  end

  it "can map vehicle model fields" do
    # first set up some make and class objects
    vehicle_make = FactoryGirl.create :vehicle_make, make: 'ASTON MARTIN'
    vehicle_class = FactoryGirl.create :vehicle_class, vehicle_class: 'small car'

    row = @csv.first
    year = '2013'

    mapping = @subject.map_vehicle_model_fields(row, year)
    mapping[:model].must_equal 'DB9'
    mapping[:model_year].to_s.must_equal '2013'
    mapping[:vehicle_make_id] = vehicle_make.id
    mapping[:vehicle_class_id] = vehicle_class.id
  end

end

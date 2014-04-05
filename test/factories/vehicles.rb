FactoryGirl.define do
  factory :vehicle_class do
    vehicle_class "small car"
    source "EPA"
  end

  factory :vehicle_make do
    make "SomeMake"
    source "EPA"
  end

  factory :vehicle_model do
    model "Model S"
    model_year "2012"
    engine_volume "-1"
    cylinders "0"
    transmission "Auto-1"
    drive "2WD"
    fuel "Electricity"
    sales_area "Federal Tier 2 Bin 1"
    air_pollution_score 10
    city_mpg 88
    hwy_mpg 90
    combined_mpg 89
    greenhouse_gas_score 10
    smart_way true

    trait :with_class do
      after(:create) do |m|
        m.vehicle_class = create :vehicle_class
      end
    end

    trait :with_make do
      ignore do
        make "SomeMake"
      end
      after(:create) do |vm, proxy|
        vm.vehicle_make = create :vehicle_make, make: proxy.make
      end
    end
  end

end


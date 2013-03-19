class CreateGreenVehicles < ActiveRecord::Migration
  def up
    create_table :green_vehicles do |t|
      t.string :make
      t.string :model
      t.decimal :engine_volume
      t.integer :cylinders
      t.string :transmission
      t.string :drive
      t.string :fuel
      t.string :sales_area
      t.string :stnd
      t.string :description
      t.string :underhood_id
      t.string :vehicle_class
      t.decimal :air_pollution_score
      t.decimal :city_mpg
      t.decimal :hwy_mpg
      t.decimal :combined_mpg
      t.decimal :greenhouse_gas_score
      t.boolean :smart_way
      
      t.timestamps
    end

  end

  def down
  end
end

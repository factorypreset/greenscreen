class GreenVehicleScoresToInteger < ActiveRecord::Migration
  def up
    change_table :green_vehicles do |t|
      t.change :air_pollution_score, :integer
      t.change :city_mpg, :integer
      t.change :hwy_mpg, :integer
      t.change :combined_mpg, :integer
      t.change :greenhouse_gas_score, :integer
    end
  end

  def down
    change_table :green_vehicles do |t|
      t.change :air_pollution_score, :decimal
      t.change :city_mpg, :decimal
      t.change :hwy_mpg, :decimal
      t.change :combined_mpg, :decimal
      t.change :greenhouse_gas_score, :decimal
    end
  end
end

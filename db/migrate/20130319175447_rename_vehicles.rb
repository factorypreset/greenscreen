class RenameVehicles < ActiveRecord::Migration
  def up
    rename_table :green_vehicles, :vehicles
  end

  def down
    rename_table :vehicles, :green_vehicles
  end
end

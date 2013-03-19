class RenameVehiclesTable < ActiveRecord::Migration
  def up
    rename_table :vehicles, :vehicle_models
  end

  def down
    rename_table :vehicle_models, :vehicles
  end
end

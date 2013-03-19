class AddVehicleClassIdToModels < ActiveRecord::Migration
  def up
    add_column :vehicle_models, :vehicle_class_id, :integer
  end

  def down
    remove_column :vehicle_models, :vehicle_class_id
  end
end

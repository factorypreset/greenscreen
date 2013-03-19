class SplitOutVehicleClass < ActiveRecord::Migration
  def up
    create_table :vehicle_classes do |t|
      t.string :vehicle_class
    end
    remove_column :vehicle_models, :vehicle_class
  end

  def down
    add_column :vehicle_models, :vehicle_class
    drop_table :vehicle_classes
  end
end

class AddSourceToVehicleClasses < ActiveRecord::Migration
  def up
    add_column :vehicle_classes, :source, :string
  end

  def down
    remove_column :vehicle_classes, :source
  end
end

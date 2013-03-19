class AddSourceColumn < ActiveRecord::Migration
  def up
    add_column :vehicle_makes, :source, :string
    add_column :vehicle_models, :source, :string
  end

  def down
    remove_column :vehicle_makes, :source
    remove_column :vehicle_models, :source
  end
end

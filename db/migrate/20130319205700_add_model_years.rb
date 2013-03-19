class AddModelYears < ActiveRecord::Migration
  def up
    add_column :vehicle_models, :model_year, :string
  end

  def down
    remove_column :vehicle_models, :model_year
  end
end

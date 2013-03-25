class YearToInteger < ActiveRecord::Migration
  def up
    change_column :vehicle_models, :model_year, :integer
  end

  def down
    change_column :vehicle_models, :model_year, :string
  end
end

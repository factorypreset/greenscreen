class StandardizeForeignKey < ActiveRecord::Migration
  def up
    change_table :green_vehicles do |t|
      t.rename :make_id, :vehicle_make_id
    end
  end

  def down
    change_table :green_vehicles do |t|
      t.rename :vehicle_make_id, :make_id
    end
  end
end

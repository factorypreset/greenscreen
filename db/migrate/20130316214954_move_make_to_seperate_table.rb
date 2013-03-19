class MoveMakeToSeperateTable < ActiveRecord::Migration
  def up
    change_table :green_vehicles do |t|
      t.remove :make
      t.integer :make_id
    end
  end

  def down
    change_table :green_vehicles do |t|
      t.remove :make_id
      t.string :make
    end
  end
end

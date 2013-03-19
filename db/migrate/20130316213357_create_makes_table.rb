class CreateMakesTable < ActiveRecord::Migration
  def up
    create_table :vehicle_makes do |t|
      t.string :make

      t.timestamps
    end
  end

  def down
  end
end

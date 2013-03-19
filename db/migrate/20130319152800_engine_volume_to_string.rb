class EngineVolumeToString < ActiveRecord::Migration
  def up
    change_table :green_vehicles do |t|
      t.change :engine_volume, :string
    end
  end

  def down
    change_table :green_vehicles do |t|
      t.change :engine_volume, :decimal
    end
  end
end

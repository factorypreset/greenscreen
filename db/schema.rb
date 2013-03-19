# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130319205700) do

  create_table "vehicle_classes", :force => true do |t|
    t.string "vehicle_class"
    t.string "source"
  end

  create_table "vehicle_makes", :force => true do |t|
    t.string   "make"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "source"
  end

  create_table "vehicle_models", :force => true do |t|
    t.string   "model"
    t.string   "engine_volume"
    t.integer  "cylinders"
    t.string   "transmission"
    t.string   "drive"
    t.string   "fuel"
    t.string   "sales_area"
    t.string   "stnd"
    t.string   "description"
    t.string   "underhood_id"
    t.integer  "air_pollution_score"
    t.integer  "city_mpg"
    t.integer  "hwy_mpg"
    t.integer  "combined_mpg"
    t.integer  "greenhouse_gas_score"
    t.boolean  "smart_way"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "vehicle_make_id"
    t.string   "source"
    t.integer  "vehicle_class_id"
    t.string   "model_year"
  end

end

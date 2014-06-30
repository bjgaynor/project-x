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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140629113020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "imports", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "spreadsheet_file_name"
    t.string   "spreadsheet_content_type"
    t.integer  "spreadsheet_file_size"
    t.datetime "spreadsheet_updated_at"
  end

  create_table "listings", force: true do |t|
    t.string   "address"
    t.string   "zestimate"
    t.string   "forecast_percentage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "zpid"
    t.string   "city_state_zip"
    t.string   "rent_zestimate"
    t.string   "homepage"
    t.integer  "import_id"
  end

  add_index "listings", ["address"], name: "index_listings_on_address", using: :btree
  add_index "listings", ["city_state_zip"], name: "index_listings_on_city_state_zip", using: :btree
  add_index "listings", ["homepage"], name: "index_listings_on_homepage", using: :btree
  add_index "listings", ["import_id"], name: "index_listings_on_import_id", using: :btree
  add_index "listings", ["zpid"], name: "index_listings_on_zpid", using: :btree

end

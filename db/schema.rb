# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_03_193429) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "crops", force: :cascade do |t|
    t.string "name", null: false
    t.string "variety"
    t.integer "days_to_maturity", null: false
    t.date "date_planted", null: false
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gardens", force: :cascade do |t|
    t.string "name", null: false
    t.float "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_crops", force: :cascade do |t|
    t.bigint "location_id", null: false
    t.bigint "crop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crop_id"], name: "index_location_crops_on_crop_id"
    t.index ["location_id"], name: "index_location_crops_on_location_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.float "size"
    t.boolean "irrigated"
    t.bigint "garden_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["garden_id"], name: "index_locations_on_garden_id"
  end

  create_table "notes", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "crop_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crop_id"], name: "index_notes_on_crop_id"
  end

  add_foreign_key "location_crops", "crops"
  add_foreign_key "location_crops", "locations"
  add_foreign_key "locations", "gardens"
  add_foreign_key "notes", "crops"
end

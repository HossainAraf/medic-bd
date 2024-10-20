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

ActiveRecord::Schema[7.1].define(version: 2024_10_19_132608) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chembers", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.string "address"
    t.integer "district_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctor_schedules", force: :cascade do |t|
    t.integer "doctor_id"
    t.integer "district_id"
    t.integer "chember_id"
    t.string "available_day"
    t.string "available_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "specification_id", null: false
    t.integer "display_order", null: false
    t.string "degree", limit: 255
    t.string "designation", limit: 255
    t.string "chember", limit: 255
    t.string "time", limit: 255
    t.string "contact", limit: 255
    t.string "expertise", limit: 255
  end

  create_table "specifications", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  create_table "user_feedbacks", force: :cascade do |t|
    t.string "feedback"
    t.string "name"
    t.string "email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "doctors", "specifications", name: "doctors_specification_id_fkey"
end

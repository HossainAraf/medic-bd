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

ActiveRecord::Schema[7.1].define(version: 2025_03_25_211512) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chambers", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.string "address"
    t.bigint "district_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_chambers_on_district_id"
    t.index ["name", "district_id"], name: "index_chambers_on_name_and_district_id", unique: true
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_districts_on_name", unique: true
  end

  create_table "doctor_schedules", force: :cascade do |t|
    t.string "available_day"
    t.string "available_time"
    t.bigint "doctor_id", null: false
    t.bigint "chamber_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "contact", null: false
    t.index ["chamber_id"], name: "index_doctor_schedules_on_chamber_id"
    t.index ["doctor_id", "chamber_id", "available_day", "available_time"], name: "index_unique_doctor_schedules", unique: true
    t.index ["doctor_id"], name: "index_doctor_schedules_on_doctor_id"
  end

  create_table "doctor_specializations", force: :cascade do |t|
    t.bigint "specialization_id", null: false
    t.bigint "doctor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "specialization_id"], name: "unique_doctor_specializations", unique: true
    t.index ["doctor_id"], name: "index_doctor_specializations_on_doctor_id"
    t.index ["specialization_id"], name: "index_doctor_specializations_on_specialization_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "specialty", null: false
    t.string "qualification", null: false
    t.string "experience", null: false
    t.string "phone"
    t.integer "order", null: false
    t.check_constraint "\"order\" >= 100000 AND \"order\" <= 9999999", name: "order_range"
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti"
    t.datetime "exp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_specializations_on_name", unique: true
  end

  add_foreign_key "chambers", "districts"
  add_foreign_key "doctor_schedules", "chambers"
  add_foreign_key "doctor_schedules", "doctors"
  add_foreign_key "doctor_specializations", "doctors"
  add_foreign_key "doctor_specializations", "specializations"
end

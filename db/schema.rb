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

ActiveRecord::Schema[7.1].define(version: 2024_11_16_030854) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chembers", force: :cascade do |t|
    t.string "name"
    t.string "chembers_type"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "district_id"
    t.index ["district_id"], name: "index_chembers_on_district_id"
  end

  create_table "districts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctor_schedules", force: :cascade do |t|
    t.string "available_day"
    t.string "available_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "doctor_id"
    t.bigint "district_id"
    t.bigint "chember_id"
    t.index ["chember_id"], name: "index_doctor_schedules_on_chember_id"
    t.index ["district_id"], name: "index_doctor_schedules_on_district_id"
    t.index ["doctor_id"], name: "index_doctor_schedules_on_doctor_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.bigint "specialization_id"
    t.string "expertise"
    t.string "qualification"
    t.string "designation"
    t.bigint "chember_id"
    t.bigint "doctor_schedule_id"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chember_id"], name: "index_doctors_on_chember_id"
    t.index ["doctor_schedule_id"], name: "index_doctors_on_doctor_schedule_id"
    t.index ["specialization_id"], name: "index_doctors_on_specialization_id"
  end

  create_table "specializations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chembers", "districts"
  add_foreign_key "doctor_schedules", "chembers"
  add_foreign_key "doctor_schedules", "districts"
  add_foreign_key "doctor_schedules", "doctors"
  add_foreign_key "doctors", "chembers"
  add_foreign_key "doctors", "doctor_schedules"
  add_foreign_key "doctors", "specializations"
end

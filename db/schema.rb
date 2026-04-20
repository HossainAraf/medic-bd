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

ActiveRecord::Schema[8.1].define(version: 2026_01_15_142407) do
  create_schema "medicbd"

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "medicbd.chambers", force: :cascade do |t|
    t.string "address"
    t.string "category"
    t.string "contact", default: "", null: false
    t.datetime "created_at", null: false
    t.bigint "district_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_chambers_on_district_id"
    t.index ["name", "district_id"], name: "index_chambers_on_name_and_district_id", unique: true
  end

  create_table "medicbd.districts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_districts_on_name", unique: true
  end

  create_table "medicbd.doctor_schedules", force: :cascade do |t|
    t.integer "available_day", null: false
    t.bigint "chamber_id", null: false
    t.datetime "created_at", null: false
    t.bigint "doctor_id", null: false
    t.time "end_time"
    t.integer "slot", null: false
    t.time "start_time"
    t.datetime "updated_at", null: false
    t.index ["chamber_id"], name: "index_doctor_schedules_on_chamber_id"
    t.index ["doctor_id", "chamber_id", "available_day", "slot"], name: "uniq_doctor_chamber_day_slot", unique: true
    t.index ["doctor_id"], name: "index_doctor_schedules_on_doctor_id"
  end

  create_table "medicbd.doctor_specializations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "doctor_id", null: false
    t.bigint "specialization_id", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "specialization_id"], name: "unique_doctor_specializations", unique: true
    t.index ["doctor_id"], name: "index_doctor_specializations_on_doctor_id"
    t.index ["specialization_id"], name: "index_doctor_specializations_on_specialization_id"
  end

  create_table "medicbd.doctors", force: :cascade do |t|
    t.string "bangla_name"
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "display_order", null: false
    t.string "experience", null: false
    t.string "name", null: false
    t.string "phone"
    t.text "photo_url"
    t.string "qualification", null: false
    t.string "registration_number"
    t.string "slug", null: false
    t.text "special_notes"
    t.string "specialty", null: false
    t.datetime "updated_at", null: false
    t.index ["phone"], name: "index_doctors_on_phone", unique: true
    t.index ["registration_number"], name: "index_doctors_on_registration_number", unique: true
    t.index ["slug"], name: "index_doctors_on_slug", unique: true
    t.check_constraint "display_order >= 100000 AND display_order <= 9999999", name: "display_order_range"
  end

  create_table "medicbd.medic_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "created_by"
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "phone"
    t.string "role"
    t.datetime "updated_at", null: false
    t.integer "updated_by"
    t.index ["email"], name: "index_medic_users_on_email", unique: true
  end

  create_table "medicbd.specializations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_specializations_on_name", unique: true
  end

  add_foreign_key "medicbd.chambers", "medicbd.districts"
  add_foreign_key "medicbd.doctor_schedules", "medicbd.chambers"
  add_foreign_key "medicbd.doctor_schedules", "medicbd.doctors"
  add_foreign_key "medicbd.doctor_specializations", "medicbd.doctors"
  add_foreign_key "medicbd.doctor_specializations", "medicbd.specializations"

end

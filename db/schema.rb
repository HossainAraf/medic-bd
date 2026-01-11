ActiveRecord::Schema[8.1].define(version: 2025_09_09_194233) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "chambers", force: :cascade do |t|
    t.string "address"
    t.string "category"
    t.datetime "created_at", null: false
    t.bigint "district_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["district_id"], name: "index_chambers_on_district_id"
    t.index ["name", "district_id"], name: "index_chambers_on_name_and_district_id", unique: true
  end

  create_table "districts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "doctor_schedules", force: :cascade do |t|
    t.string "available_day"
    t.string "available_time"
    t.bigint "chamber_id", null: false
    t.string "contact", null: false
    t.datetime "created_at", null: false
    t.bigint "doctor_id", null: false
    t.datetime "updated_at", null: false
    t.index ["chamber_id"], name: "index_doctor_schedules_on_chamber_id"
    t.index ["doctor_id"], name: "index_doctor_schedules_on_doctor_id"
  end

  create_table "doctor_specializations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "doctor_id", null: false
    t.bigint "specialization_id", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id", "specialization_id"], name: "unique_doctor_specializations", unique: true
    t.index ["doctor_id"], name: "index_doctor_specializations_on_doctor_id"
    t.index ["specialization_id"], name: "index_doctor_specializations_on_specialization_id"
  end

  create_table "doctors", force: :cascade do |t|
    t.string "bangla_name"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "experience", null: false
    t.string "name", null: false
    t.integer "order", null: false
    t.string "phone"
    t.text "photo_url"
    t.string "qualification", null: false
    t.text "special_notes"
    t.string "specialty", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "bangla_name"], name: "index_doctors_on_name_and_bangla_name_unique", unique: true
    t.check_constraint "\"order\" >= 100000 AND \"order\" <= 9999999", name: "order_range"
  end

  create_table "medic_users", force: :cascade do |t|
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

  create_table "specializations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "chambers", "districts"
  add_foreign_key "doctor_schedules", "chambers"
  add_foreign_key "doctor_schedules", "doctors"
  add_foreign_key "doctor_specializations", "doctors"
  add_foreign_key "doctor_specializations", "specializations"
end

class AddForeignKeyToDoctorSchedules < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :doctor_schedules,  :doctors
    add_foreign_key :doctor_schedules,  :districts
    add_foreign_key :doctor_schedules,  :chembers
  end
end

class AddUniqueConstraintToDoctorSchedules < ActiveRecord::Migration[7.1]
  def change
    add_index :doctor_schedules, [:doctor_id, :chamber_id, :available_day, :available_time], unique: true, name: 'index_unique_doctor_schedules'
  end
end

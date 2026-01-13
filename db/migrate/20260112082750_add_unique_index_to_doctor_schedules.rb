class AddUniqueIndexToDoctorSchedules < ActiveRecord::Migration[8.1]
  def change
    add_index :doctor_schedules,
              [:doctor_id, :chamber_id, :available_day, :slot],
              unique: true,
              name: "uniq_doctor_chamber_day_slot"
  end
  # Index was intended in NormalizeDoctorSchedulesWithDayAndSlot
  # but added here due to prior migration not applying it
end

class NormalizeDoctorSchedulesWithDayAndSlot < ActiveRecord::Migration[8.1]
  def change
    # Normalizes schedules to enforce one slot per doctor per chamber per day
    add_column :doctor_schedules, :slot, :integer
    add_column :doctor_schedules, :start_time, :time
    add_column :doctor_schedules, :end_time, :time

    add_index :doctor_schedules, [:doctor_id, :chamber_id, :available_day, :slot], unique: true, name: "uniq_doctor_chamber_day_slot"
    
  end
end

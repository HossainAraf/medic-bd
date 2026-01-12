class ChangeColumnNullFalseDoctorSchedule < ActiveRecord::Migration[8.1]
  def change
    change_column_null :doctor_schedules, :available_day, false
    change_column_null :doctor_schedules, :slot, false
  end
end

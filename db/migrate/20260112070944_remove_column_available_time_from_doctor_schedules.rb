class RemoveColumnAvailableTimeFromDoctorSchedules < ActiveRecord::Migration[8.1]
  def change
    remove_column :doctor_schedules, :available_time, :string
  end
end

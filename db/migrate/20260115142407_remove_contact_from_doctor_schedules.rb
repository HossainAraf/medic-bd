class RemoveContactFromDoctorSchedules < ActiveRecord::Migration[8.1]
  def change
    remove_column :doctor_schedules, :contact, :string
  end
end

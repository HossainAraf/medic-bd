class AddContactToDoctorSchedules < ActiveRecord::Migration[7.1]
  def change
    add_column :doctor_schedules, :contact, :string, null: false
  end
end

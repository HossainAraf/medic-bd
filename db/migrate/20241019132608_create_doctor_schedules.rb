class CreateDoctorSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_schedules do |t|
      t.integer :doctor_id
      t.integer :district_id
      t.integer :chember_id
      t.string :available_day
      t.string :available_time

      t.timestamps
    end
  end
end

class CreateDoctorSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_schedules do |t|
      t.references :doctor, null: false, foreign_key: true
      t.references :chember, null: false, foreign_key: true
      t.string :available_day
      t.string :available_time

      t.timestamps
    end
  end
end

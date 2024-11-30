class CreateDoctorSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :doctor_schedules do |t|
      t.string :available_day
      t.string :available_time
      t.references :doctor, null: false, foreign_key: true
      t.references :chamber, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class ChangeAvailableDayToInteger < ActiveRecord::Migration[8.1]
  def change
    # Recreates available_day column as integer enum for strict schedule modeling
     remove_column :doctor_schedules, :available_day
     add_column :doctor_schedules, :available_day, :integer, null: true
  end
end

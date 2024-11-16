class UpdateIntegerToReferences < ActiveRecord::Migration[7.1]
  def change
     # Doctor Schedule Table Changes
     remove_column :doctor_schedules, :doctor_id, :integer
     remove_column :doctor_schedules, :district_id, :integer
     remove_column :doctor_schedules, :chember_id, :integer
 
     add_reference :doctor_schedules, :doctor, foreign_key: true
     add_reference :doctor_schedules, :district, foreign_key: true
     add_reference :doctor_schedules, :chember, foreign_key: true

     remove_column :chembers, :district_id, :integer
     add_reference :chembers, :district, foreign_key: true

     
  end
end

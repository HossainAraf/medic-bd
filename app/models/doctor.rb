class Doctor < ApplicationRecord
  belongs_to :specification
  Doctor.joins(:specification, doctor_schedule:  :chember)
              .select('doctors.name, chembers.name as chember_name, doctor_schedules.available_day, doctor_schedules.available_time')
              .where('specifications.name: {selected_specification}')
end

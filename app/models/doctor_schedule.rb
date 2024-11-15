class DoctorSchedule < ApplicationRecord
  belongs_to :district
  belongs_to :doctor
  belongs_to :chember
end

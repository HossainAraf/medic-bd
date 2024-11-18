class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chember
end

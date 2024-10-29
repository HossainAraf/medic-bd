class DoctorSchedule < ApplicationRecord
  belongs_to :district
  belongs_to :doctor
end

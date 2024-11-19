class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chamber

  validates :available_day, presence: true
  validates :available_time, presence: true
end

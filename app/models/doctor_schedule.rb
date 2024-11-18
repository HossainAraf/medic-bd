class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chember

  validates :available_day, presence: true
  validates :available_time, presence: true
end

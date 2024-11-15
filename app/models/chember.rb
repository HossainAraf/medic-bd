class Chember < ApplicationRecord
  belongs_to :district
  has_many :doctor_schedules
end

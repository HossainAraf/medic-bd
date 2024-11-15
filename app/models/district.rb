class District < ApplicationRecord
  has_many :chembers
  has_many :doctor_schedules
end

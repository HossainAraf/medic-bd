class District < ApplicationRecord
  has_many :chambers
  has_many :doctors, through: :chambers
  has_many :doctor_schedules, through: :chambers

  # validates :name, presence: true
end

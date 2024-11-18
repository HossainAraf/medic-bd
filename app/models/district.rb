class District < ApplicationRecord
  has_many :chembers
  has_many :doctors, through: :chembers
  has_many :doctor_schedules, through: :chembers

  validates :name, presence: true
end

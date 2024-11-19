class Chamber < ApplicationRecord
  belongs_to :district
  has_many :doctor_schedules
  has_many :doctors, through: :doctor_schedules

  validates :name, presence: true
end

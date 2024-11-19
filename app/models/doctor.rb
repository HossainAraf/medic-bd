class Doctor < ApplicationRecord
  validates :order, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: 100_000,
                                    less_than_or_equal_to: 9_999_999 }
  has_many :doctor_specializations
  has_many :specializations, through: :doctor_specializations
  has_many :doctor_schedules
  has_many :chembers, through: :doctor_schedules

  validates :name, presence: true

  scope :by_specialization, ->(specialization_id) { joins(:specializations).where(specializations: { id: specialization_id }) }
  scope :by_district, ->(district_id) { joins(:chembers).where(chembers: { district_id: district_id }) }
end

# require_dependency 'strip_whitespace'

class Doctor < ApplicationRecord

  include ::StripWhitespace
  # validates :order, presence: true,
  #                   numericality: { only_integer: true,
  #                                   greater_than_or_equal_to: 100_000,
  #                                   less_than_or_equal_to: 9_999_999 }
  has_many :doctor_specializations
  has_many :specializations, through: :doctor_specializations
  has_many :doctor_schedules
  has_many :chambers, through: :doctor_schedules

  accepts_nested_attributes_for :chambers
  accepts_nested_attributes_for :doctor_specializations
  accepts_nested_attributes_for :doctor_schedules, allow_destroy: true

  # validates :name, presence: true

  scope :by_specialization, lambda { |specialization_id|
    joins(:specializations).where(specializations: { id: specialization_id })
  }
  scope :by_district, ->(district_id) { joins(:chamber).where(chamber: { district_id: }) }
end

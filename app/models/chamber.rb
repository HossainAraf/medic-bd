class Chamber < ApplicationRecord
  belongs_to :district
  has_many :doctor_schedules
  has_many :doctors, through: :doctor_schedules

  accepts_nested_attributes_for :doctor_schedules

  # Include the StripWhitespace module for trimming direct attributes
  include ::StripWhitespace

  # Validation for required fields
  validates :name, :category, :address, presence: true
  validates :contact,
            presence: true,
            format: { with: /\A\+?\d{6,15}\z/, message: 'must be a valid phone number' }
end

class Chamber < ApplicationRecord
  belongs_to :district
  has_many :doctor_schedules
  has_many :doctors, through: :doctor_schedules

  accepts_nested_attributes_for :doctor_schedules

  # Include the StripWhitespace module for trimming direct attributes
  include ::StripWhitespace

  # Allowed category values
  VALID_CATEGORIES = ['Diagnostic', 'Clinic', 'Hospital', 'Private Chamber'].freeze

  # Validation for required fields
  validates :name, :category, :address, :district_id, presence: true
  validates :category, inclusion: { in: VALID_CATEGORIES, message: "%{value} is not a valid category" }

  # Callback to strip whitespace from nested attributes
  before_save :strip_nested_attributes_whitespace

  private

  # Trims whitespace from all nested attributes
  def strip_nested_attributes_whitespace
    doctor_schedules.each do |schedule|
      schedule.attributes.each do |key, value|
        schedule[key] = value.strip.gsub(/\s+/, ' ') if value.is_a?(String)
      end
    end
  end
end

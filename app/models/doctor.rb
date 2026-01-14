# require_dependency 'strip_whitespace'

class Doctor < ApplicationRecord
  before_validation :set_slug, on: :create
  include ::StripWhitespace

  # Associations
  has_many :doctor_specializations, dependent: :destroy
  has_many :specializations, through: :doctor_specializations
  has_many :doctor_schedules, dependent: :restrict_with_error
  has_many :chambers, through: :doctor_schedules

  # Nested Attributes
  accepts_nested_attributes_for :chambers
  accepts_nested_attributes_for :doctor_specializations

  # Callbacks
  before_save :normalize_display_order

  # Validations
  validates :doctor_specializations, presence: true
  validates :slug, presence: true, uniqueness: true

  validates :display_order, presence: true,
                            numericality: { only_integer: true,
                                            greater_than_or_equal_to: 100_000,
                                            less_than_or_equal_to: 9_999_999 }
  validates :name, presence: true

  # Scopes
  scope :by_specialization, lambda { |specialization_id|
    joins(:specializations).where(specializations: { id: specialization_id })
  }

  scope :by_district, lambda { |district_id|
    joins(:chamber).where(chamber: { district_id: })
  }

  # Methods
  private

  def normalize_display_order
    self.display_order = display_order.to_i if display_order.present? # Converts to integer to strip leading zeros
  end

  def set_slug
    self.slug ||= format('dr-bd-%06d', id || (Doctor.maximum(:id).to_i + 1))
  end
end

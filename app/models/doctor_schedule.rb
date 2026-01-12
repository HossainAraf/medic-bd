class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chamber, optional: true # Avoid validation error during nested attributes processing
  before_save :ensure_chamber
  # validates :available_day, presence: true
  # validates :available_time, presence: true
  include ::StripWhitespace

  accepts_nested_attributes_for :chamber
  before_save :ensure_chamber

  enum available_day: {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }

  enum slot: {
    morning: 0,
    afternoon: 1,
    evening: 2
  }

  validates :contact, presence: true


  private

  def ensure_chamber
    return unless chamber.blank? && chamber_attributes.present?

    self.chamber = Chamber.create!(chamber_attributes)
  end
end

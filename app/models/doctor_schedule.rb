class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chamber, optional: true # Avoid validation error during nested attributes processing
  before_save :ensure_chamber
  # validates :available_day, presence: true
  # validates :available_time, presence: true
  include ::StripWhitespace

  accepts_nested_attributes_for :chamber

  validates :contact, presence: true

  before_save :ensure_chamber

  private

  def ensure_chamber
    return unless chamber.blank? && chamber_attributes.present?

    self.chamber = Chamber.create!(chamber_attributes)
  end
end

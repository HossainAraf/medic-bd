class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chamber, optional: true # Avoid validation error during nested attributes processing
  before_save :ensure_chamber

  include ::StripWhitespace

  accepts_nested_attributes_for :chamber

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

  validates :contact, presence: true, format: { with: /\A\+?\d{6,15}\z/, message: "must be a valid phone number" }
  validates :available_day, presence: true
  validates :slot, presence: true
  validates :slot, uniqueness: { scope: [:doctor_id, :chamber_id, :available_day],
                                 message: "Schedule slot already exists for this doctor in the specified chamber on the given day.", case_sensitive: false }


  private

  def ensure_chamber
    return unless chamber.blank? && chamber_attributes.present?

    self.chamber || Chamber.new(chamber_attributes)
  end
end

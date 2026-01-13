class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chamber

  include ::StripWhitespace

  accepts_nested_attributes_for :chamber, reject_if: :all_blank

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
  validates :available_day, :slot, :start_time, :end_time, presence: true
  validates :slot, uniqueness: { scope: [:doctor_id, :chamber_id, :available_day],
                                 message: "Schedule slot already exists for this doctor in the specified chamber on the given day.", case_sensitive: false }

  before_validation :ensure_chamber

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end

  private

  def ensure_chamber
    return unless chamber.blank? && chamber_attributes.present?

    self.chamber || Chamber.new(chamber_attributes)
  end
end

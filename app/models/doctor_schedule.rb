class DoctorSchedule < ApplicationRecord
  belongs_to :doctor
  belongs_to :chamber

  include ::StripWhitespace

  enum :available_day, {
    sunday: 0,
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6
  }

  enum :slot, {
    morning: 0,
    afternoon: 1,
    evening: 2
  }

  validates :available_day, :slot, :start_time, :end_time, presence: true

  validate :end_time_after_start_time

  validates :slot, uniqueness: {
    scope: %i[doctor_id chamber_id available_day],
    message: 'Schedule slot already exists for this doctor in the specified chamber on the given day.'
  }

  private

  def end_time_after_start_time
    return if start_time.blank? || end_time.blank?

    errors.add(:end_time, 'must be after start time') if end_time <= start_time
  end
end

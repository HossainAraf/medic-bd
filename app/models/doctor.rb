class Doctor < ApplicationRecord
  belongs_to :specialization
  has_many :doctor_schedules
  has_many :chembers, through: :doctor_schedules
  def self.with_schedule(selected_specialization)
    joins(:specialization, doctor_schedules: :chembers)
      .select('doctors.name,
      chembers.name as chember_name,
      doctor_schedules.available_day, doctor_schedules.available_time')
      .where('specializations.name = ?', selected_specialization)
  end
end

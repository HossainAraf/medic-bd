class DoctorSpecialization < ApplicationRecord
  belongs_to :doctor
  belongs_to :specialization

  validates :doctor_id, uniqueness: { scope: :specialization_id, message: 'already has this specialization' }
end

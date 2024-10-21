class Chember < ApplicationRecord
  belongs_to :District
  has_many :DoctorSchedule
end

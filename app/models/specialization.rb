class Specialization < ApplicationRecord
  has_many :doctor_specializations
  has_many :doctors, through: :doctor_specializations
end

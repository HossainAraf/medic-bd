class Specialization < ApplicationRecord
  has_many :doctor_specializations, dependent: :restrict_with_error
  has_many :doctors, through: :doctor_specializations

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  include ::StripWhitespace
end

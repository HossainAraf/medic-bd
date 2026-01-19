class District < ApplicationRecord
  has_many :chambers, dependent: :destroy
  has_many :doctors, through: :chambers
  has_many :doctor_schedules, through: :chambers

  include ::StripWhitespace

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end

class Doctor < ApplicationRecord
  include ::StripWhitespace

  has_many :doctor_specializations, dependent: :destroy
  has_many :specializations, through: :doctor_specializations
  has_many :doctor_schedules, dependent: :restrict_with_error
  has_many :chambers, through: :doctor_schedules

  accepts_nested_attributes_for :doctor_specializations

  before_validation :ensure_slug, on: :create
  after_create :finalize_slug

  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true

  private

  def ensure_slug
    self.slug ||= "tmp-#{SecureRandom.uuid}"
  end

  def finalize_slug
    update_column(:slug, format('dr-bd-%06d', id))
  end
end

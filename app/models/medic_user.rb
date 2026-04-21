class MedicUser < ApplicationRecord
  has_secure_password

  before_validation :set_default_role, on: :create

  # validation
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true, inclusion: { in: %w[user admin] }
  validates :password, presence: true, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  private

  def set_default_role
    self.role = 'user' if role.blank?
  end
end

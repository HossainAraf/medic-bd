require 'test_helper'

class MedicUserTest < ActiveSupport::TestCase
  # --------------------------
  # Presence Validations
  # --------------------------
  test 'is invalid without email' do
    user = MedicUser.new
    assert_not user .valid?
    assert_includes user.errors[:email], "can't be blank"
  end

  test 'is invalid without password' do
    user = MedicUser.new
    assert_not user .valid?
    assert_includes user.errors[:password], "can't be blank"
  end

  # --------------------------
  # Format Validations
  # --------------------------
  test 'is invalid with malformed email' do
    user = MedicUser.new(
      email: "not-an-email",
      password: "securepassword"
    )
    assert_not user.valid?
  end

  test 'is valid with properly formatted email' do
    user = MedicUser.new(
      email: "user@example.com",
      password: "securepassword"
    )
    assert user.invalid? # Alternative: 'assert_not user.valid?''
  end

  # --------------------------
  # Uniqueness Validations
  # --------------------------
  test 'is invalid with duplicate email' do
    existing_user = MedicUser.create!(
      email: "user@example.com",
      password: "securepassword"
    )
    duplicate_user = MedicUser.new(
      email: "user@example.com",
      password: "anotherpassword"
    )
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

end
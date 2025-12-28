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

  #
end

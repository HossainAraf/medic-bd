require 'test_helper'

class SpecializationTest < ActiveSupport::TestCase
 # ---------------------
  # Presence Validations
  # --------------------
  test 'is valid without name' do
    specialization = Specialization.new
    assert_not specialization.valid?
    assert_includes specialization.errors[:name], "can't be blank"
  end

  # ---------------------
  # Uniqueness Validations
  # --------------------
  test 'is invalid with duplicate name (case insensitive)' do
    Specialization.create!(name: "Cardiology")
    duplicate_specialization = Specialization.new(name: "Skin")

    assert_not duplicate_specialization.valid?
    assert_includes duplicate_specialization.errors[:name], "has already been taken"
  end
end

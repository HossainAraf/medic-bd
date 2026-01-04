require 'test_helper'

class DistrictTest < ActiveSupport::TestCase
  # ---------------------
  # Presence Validations
  # ---------------------
  test 'is invalid without name' do
    district = District.new
    assert_not district.valid?
    assert_includes district.errors[:name], "can't be blank"
  end

  # ---------------------
  # Uniqueness Validations
  # ---------------------
  test 'is invalid with duplicate name (case insensitive)' do
    district = District.create!(name: 'Dhaka')
    duplicate_district = District.new(name: 'dhaka')

    assert_not duplicate_district.valid?
    assert_includes duplicate_district.errors[:name], 'has already been taken'
  end
end
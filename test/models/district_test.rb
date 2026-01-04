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

end
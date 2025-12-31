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
end

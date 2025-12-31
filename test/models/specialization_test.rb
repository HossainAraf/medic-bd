require 'test_helper'

class SpecializationTest < ActiveSupport::TestCase
 # ---------------------
  # Presence Validations
  # --------------------
  # fail example
  test 'is valid without name' do
    specialization = Specialization.new
    assert_not specialization.valid?
    assert_includes specialization.errors, "can't be blank" # This will fail because name is required
  end
end

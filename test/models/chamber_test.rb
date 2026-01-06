require 'test_helper'

class ChamberTest < ActiveSupport::TestCase
  # ---------------------
  # Presence Validations
  # ---------------------
  # test 'invalid without name' do
  #   chamber = Chamber.new(category: 'Hospital', address: 'Rubir mor', district_id: 1)
  #   assert_not chamber.valid?
  #   assert_includes chamber.errors[:name], "can't be blank"
  # end
  test 'invalid without required field' do
    chamber = Chamber.new()
    assert_not chamber.valid?
    assert_includes chamber.errors[:name], "can't be blank"
    assert_includes chamber.errors[:category], "can't be blank"
    assert_includes chamber.errors[:address], "can't be blank"
    assert_includes chamber.errors[:district_id], "can't be blank"
  end
end

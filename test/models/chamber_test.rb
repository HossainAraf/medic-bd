require 'test_helper'

class ChamberTest < ActiveSupport::TestCase
  # ---------------------
  # Presence Validations
  # ---------------------
  test 'invalid without name' do
    chamber = Chamber.new(category: 'Hospital', address: 'Rubir mor', district_id: 1)
    assert_not chamber.valid?
    assert_includes chamber.errors[:name], "can't be blank"
  end

  test 'invalid without category' do
    chamber = Chamber.new(name: 'City Hospital', address: 'Rubir mor', district_id: 1)
    assert_not chamber.valid?
    assert_includes chamber.errors[:category], "can't be blank"
  end

  test 'invalid without address' do
    chamber = Chamber.new(name: 'City Hospital', category: 'Hospital', district_id: 1)
    assert_not chamber.valid?
    assert_includes chamber.errors[:address], "can't be blank"
  end
  test 'invalid without district_id' do
    chamber = Chamber.new(name: 'City Hospital', category: 'Hospital', address: 'Rubir mor')
    assert_not chamber.valid?
    assert_includes chamber.errors[:district_id], "can't be blank"
  end

  # ---------------------
  # Valid Case
  # ---------------------
  test 'valid with all required fields' do
    district = District.new(name: 'Dhaka')
    district.save    # Or create! to ensure it gets an ID (instead of new+save)
    chamber = Chamber.new(name: 'City Hospital', category: 'Hospital', address: 'Rubir mor', district: district)
    assert chamber.valid?
  end

  # ---------------------
  # Whitespace Stripping
  # ---------------------

end

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

  # ---------------------
  # Valid Case
  # ---------------------
  test 'valid with all required fields' do
    district = District.new(name: 'Dhaka')
    district.save # Or create! to ensure it gets an ID (instead of new+save)
    chamber = Chamber.new(name: 'City Hospital', category: 'Hospital', address: 'Rubir mor', district: district,
                          contact: '0123456789')
    assert chamber.valid?
  end

  # ---------------------
  # Whitespace Stripping
  # ---------------------
  test 'strips whitespace from name' do
    district = District.new(name: 'Dhaka')
    district.save
    chamber = Chamber.create!(name: '  City Hospital  ', category: 'Hospital', address: 'Rubir mor',
                              district: district, contact: '0123456789')
    chamber.valid?
    assert_equal 'City Hospital', chamber.name
  end

  test 'strips whitespace from category' do
    district = District.create!(name: 'Naogaon')
    chamber = Chamber.create!(name: 'City Hospital', category: '  Hospital  ', address: 'Rubir mor',
                              district: district, contact: '0123456789')
    assert_equal 'Hospital', chamber.category
  end

  test 'strips whitespace from address' do
    district = District.create(name: 'Chittagong')
    chamber = Chamber.create(name: 'City Hospital', category: 'Hospital', address: '  Rubir mor', district: district,
                             contact: '0123456789')
    assert_equal 'Rubir mor', chamber.address
  end
end

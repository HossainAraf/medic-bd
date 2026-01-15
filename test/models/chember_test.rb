require 'test_helper'

class ChemberTest < ActiveSupport::TestCase
  test "should save chamber with valid category" do
    district = districts(:one)
    chamber = Chamber.new(
      name: "Valid Chamber",
      category: "Clinic",
      address: "Test Address",
      district: district
    )
    assert chamber.save, "Failed to save chamber with valid category"
  end

  test "should not save chamber with invalid category" do
    district = districts(:one)
    chamber = Chamber.new(
      name: "Invalid Chamber",
      category: "InvalidCategory",
      address: "Test Address",
      district: district
    )
    assert_not chamber.save, "Saved chamber with invalid category"
    assert_includes chamber.errors[:category], "InvalidCategory is not a valid category"
  end

  test "should accept all valid categories" do
    district = districts(:one)
    Chamber::VALID_CATEGORIES.each do |valid_category|
      chamber = Chamber.new(
        name: "Chamber #{valid_category}",
        category: valid_category,
        address: "Test Address",
        district: district
      )
      assert chamber.save, "Failed to save chamber with valid category: #{valid_category}"
    end
  end

  test "should not save chamber with case-sensitive invalid category" do
    district = districts(:one)
    # Test lowercase version of valid category
    chamber = Chamber.new(
      name: "Case Sensitive Chamber",
      category: "clinic",  # lowercase, should fail
      address: "Test Address",
      district: district
    )
    assert_not chamber.save, "Saved chamber with lowercase category"
  end

  test "should require category presence" do
    district = districts(:one)
    chamber = Chamber.new(
      name: "No Category Chamber",
      category: nil,
      address: "Test Address",
      district: district
    )
    assert_not chamber.save, "Saved chamber without category"
    assert_includes chamber.errors[:category], "can't be blank"
  end
end

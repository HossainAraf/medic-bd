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
    duplicate_specialization = Specialization.new(name: "cardioloGy")

    assert_not duplicate_specialization.valid?
    assert_includes duplicate_specialization.errors[:name], "has already been taken"
  end

  # ---------------------
  # Whitespace Stripping
  # --------------------
  test 'strips leading and trailing whitespace from name' do
    specialization = Specialization.create(name: "  Neurology  ")
    assert_equal "Neurology", specialization.name
  end

  # ---------------------
  # Association Tests
  # --------------------
  test 'can be associated with doctors' do
  specialization = Specialization.create!(name: 'Cardiology')
  doctor = Doctor.create!(name: 'Dr. Test', order: 100000, experience: 10, qualification: 'MD', photo_url: 'doctor.jpg', specialty: 'Cardiology')

  DoctorSpecialization.create!(
    doctor: doctor,
    specialization: specialization
  )

  assert_includes specialization.doctors, doctor
end


end

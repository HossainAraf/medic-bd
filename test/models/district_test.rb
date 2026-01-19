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
    District.create!(name: 'Dhaka')
    duplicate_district = District.new(name: 'dhaka')

    assert_not duplicate_district.valid?
    assert_includes duplicate_district.errors[:name], 'has already been taken'
  end

  # ---------------------
  # Whitespace Stripping
  # ---------------------
  test 'strips leading and trailing whitespace from name' do
    district = District.create!(name: '  Chittagong  ')
    assert_equal 'Chittagong', district.name
  end

  # ---------------------
  # Association Tests (Optional/Unnecessary here)
  # ---------------------
  test 'can be associated with chambers' do
    district = District.create!(name: 'Sylhet')
    chamber = Chamber.create!(name: 'Sylhet Chamber', address: '123 Sylhet St', district: district, category: 'Clinic',
                              contact: '0123456789')

    assert_includes district.chambers, chamber
  end

  test 'can be associated with doctors through chambers' do
    district = District.create!(name: 'Rajshahi')
    chamber = Chamber.create!(name: 'Rajshahi Chamber', address: '456 Rajshahi St', district: district,
                              category: 'Hospital', contact: '0987654321')
    doctor = Doctor.create!(name: 'Dr. Test', display_order: 100_000, experience: 10, qualification: 'MD',
                            photo_url: 'doctor.jpg', specialty: 'General Medicine', phone: '1234567890')
    DoctorSchedule.create!(chamber: chamber, doctor: doctor, available_day: 'monday', slot: 'morning',
                           start_time: '09:00', end_time: '12:00')

    assert_includes district.doctors, doctor
  end
end

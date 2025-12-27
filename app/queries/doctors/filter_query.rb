module Doctors
  class FilterQuery
    def initialize(specialization_id:, district_id: nil)
      @specialization_id = specialization_id
      @district_id = district_id
    end

    def call
      specialization = Specialization.find_by(id: @specialization_id)
      return Doctor.none unless specialization

      doctors = Doctor
        .joins(:doctor_specializations)
        .where(doctor_specializations: { specialization_id: specialization.id })

      if @district_id.present?
        doctors = doctors.joins(:chambers)
          .where(chambers: { district_id: @district_id })
      end

      doctors.distinct
    end
  end
end

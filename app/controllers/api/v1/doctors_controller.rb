class Api::V1::DoctorsController < ApplicationController
  # GET /api/v1/doctors
  def index
    doctors = Doctor.includes(:chambers, :doctor_schedules, :specializations).all

    render json: doctors.as_json(
      include: {
        chambers: { only: %i[id name category address district_id] },
        doctor_schedules: { only: %i[id available_day available_time contact chamber_id] },
        specializations: { only: %i[id name] }
      }
    ), status: :ok
  end

  # GET /api/v1/doctors/:id
  def show
    doctor = Doctor.includes(:chambers, :doctor_schedules, :specializations).find(params[:id])

    render json: doctor.as_json(
      include: {
        chambers: { only: %i[id name category address district_id] },
        doctor_schedules: { only: %i[id available_day available_time contact chamber_id] },
        specializations: { only: %i[id name] }
      }
    ), status: :ok
  end

  # GET /api/v1/doctors/filtered_doctors
  def filtered_doctors
    Rails.logger.info "Filtered Doctors Params: #{params.inspect}"

    district = District.find_by(id: params[:district_id]) if params[:district_id].present?
    specialization_id = params[:specialization_id] # Using specialization_id instead of name

    # Find specialization by ID
    specialization = Specialization.find_by(id: specialization_id)

    unless specialization
      Rails.logger.error "Specialization not found: #{specialization_id}"
      render json: { error: 'Specialization not found' }, status: :not_found and return
    end

    doctors = if district
                district.doctors.joins(:doctor_specializations)
                  .where(doctor_specializations: { specialization_id: specialization.id })
              else
                Doctor.joins(:doctor_specializations)
                  .where(doctor_specializations: { specialization_id: specialization.id })
              end

    render json: doctors.as_json(
      include: {
        chambers: { only: %i[id name category address district_id] },
        doctor_schedules: { only: %i[id available_day available_time contact chamber_id] },
        specializations: { only: %i[id name] }
      }
    ), status: :ok
  end

  # POST /api/v1/doctors
  def create
    ActiveRecord::Base.transaction do
      # Preprocess the doctor schedules to handle chamber attributes
      processed_schedules = preprocess_schedules(doctor_params[:doctor_schedules_attributes])

      # Build the doctor with processed schedules
      @doctor = Doctor.new(doctor_params.except(:doctor_schedules_attributes))
      @doctor.doctor_schedules.build(processed_schedules)

      if @doctor.save
        render json: @doctor.as_json(
          include: {
            chambers: { only: %i[id name category address district_id] },
            doctor_schedules: { only: %i[id available_day available_time contact chamber_id] },
            specializations: { only: %i[id name] }
          }
        ), status: :created
      else
        render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def preprocess_schedules(schedules_attributes)
    schedules_attributes.map do |schedule|
      if schedule[:chamber_attributes].present?
        chamber_attributes = schedule.delete(:chamber_attributes)

        # Find existing chamber or create a new one
        existing_chamber = Chamber.find_or_create_by!(
          name: chamber_attributes[:name],
          district_id: chamber_attributes[:district_id]
        ) do |chamber|
          chamber.category = chamber_attributes[:category]
          chamber.address = chamber_attributes[:address]
        end

        # Replace chamber_attributes with chamber_id
        schedule[:chamber_id] = existing_chamber.id
      end
      schedule
    end
  end

  def doctor_params
    params.require(:doctor).permit(
      :name, :specialty, :order, :qualification, :experience, :phone,
      chambers_attributes: %i[name category address district_id],
      doctor_specializations_attributes: [:specialization_id],
      doctor_schedules_attributes: [:available_day, :available_time, :contact,
                                    { chamber_attributes: %i[name category address district_id] }]
    )
  end
end

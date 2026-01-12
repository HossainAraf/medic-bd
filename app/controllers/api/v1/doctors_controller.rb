class Api::V1::DoctorsController < ApplicationController
  # Skip auth for public GET requests
  skip_before_action :authorize_request, only: %i[index show by_specialization_query filter_by_order]
  # Set doctor for show and update actions
  before_action :set_doctor, only: %i[show update]
  # Ensure these actions are authenticated and user is an admin
  # For actions that modify data (create, update, destroy), run both:
  # 1. authorize_request (sets @current_user)
  # 2. authorize_admin (checks if @current_user is an admin)
  before_action :authorize_request, only: %i[create update]
  before_action :authorize_admin, only: %i[create update]
  # {/*Destroy action also needed to be restricted to admin only but currently not implemented*/}

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
    render json: @doctor.as_json(
      include: {
        chambers: { only: %i[id name category address district_id] },
        doctor_schedules: { only: %i[id available_day available_time contact chamber_id] },
        specializations: { only: %i[id name] }
      }
    ), status: :ok
  end

  # FILTER BY DOCTOR'S DISPLAY ORDER
  # GET /api/v1/doctors/display_order/:display_order
  def filter_by_display_order
    doctors = Doctor.where(display_order: params[:display_order])
    render json: doctors
  end

  # GET /api/v1/doctors/by_specialization_query?specialization_id=<specialization_id>&district_id=<district_id>
  def by_specialization_query
    doctors = Doctors::FilterQuery.new(
      specialization_id: params[:specialization_id],
      district_id: params[:district_id]
    ).call

    if doctors.empty?
      render json: { message: 'No doctors found for the given criteria' }, status: :not_found
      return
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

  # UPDATE /api/v1/doctors/:id
  def update
    ActiveRecord::Base.transaction do
      processed_schedules = preprocess_schedules(doctor_params[:doctor_schedules_attributes])

      # Handle doctor_specializations separately to prevent duplicate specialization assignments
      if doctor_params[:doctor_specializations_attributes].present?
        doctor_params[:doctor_specializations_attributes].each do |specialization_param|
          specialization_id = specialization_param[:specialization_id]
          next if @doctor.specializations.exists?(id: specialization_id)

          @doctor.doctor_specializations.create!(specialization_id:)
        end
      end

      # Update doctor attributes
      if @doctor.update(doctor_params.except(:doctor_schedules_attributes, :doctor_specializations_attributes))
        # Update doctor schedules
        @doctor.doctor_schedules.destroy_all
        @doctor.doctor_schedules.create!(processed_schedules)
        render json: @doctor.as_json(
          include: {
            chambers: { only: %i[id name category address district_id] },
            doctor_schedules: { only: %i[id available_day available_time contact chamber_id] },
            specializations: { only: %i[id name] }
          }
        ), status: :ok
      else
        render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_entity
  end

  private

  def set_doctor
    @doctor = Doctor.includes(:chambers, :doctor_schedules, :specializations).find(params[:id])
  end

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
      :bangla_name, :name, :specialty, :display_order,
      :qualification, :experience, :phone, :special_notes, :description, :photo_url,
      chambers_attributes: %i[name category address district_id],
      doctor_specializations_attributes: [:specialization_id],
      doctor_schedules_attributes: [:available_day, :available_time,
                                    :contact, { chamber_attributes: %i[name category address district_id] }]
    )
  end
end

class Api::V1::DoctorsController < ApplicationController
  # Skip auth for public GET requests
  skip_before_action :authorize_request, only: %i[index show by_specialization_query filter_by_display_order]
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
        doctor_schedules: { only: %i[id available_day slot start_time end_time contact chamber_id] },
        specializations: { only: %i[id name] }
      }
    ), status: :ok
  end

  # GET /api/v1/doctors/:id
  def show
    render json: @doctor.as_json(
      include: {
        chambers: { only: %i[id name category address district_id] },
        doctor_schedules: { only: %i[id available_day slot start_time end_time contact chamber_id] },
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
        doctor_schedules: { only: %i[id available_day slot start_time end_time contact chamber_id] },
        specializations: { only: %i[id name] }
      }
    ), status: :ok
  end

  # POST /api/v1/doctors
  def create
    doctor = Doctor.new(doctor_params)
      if doctor.save
        render json: doctor, status: :created
        
      else
        render json: { errors: doctor.errors.full_messages }, status: :unprocessable_entity
      end
  end

  # UPDATE /api/v1/doctors/:id
  def update
    if @doctor.update(doctor_params)
      render json: @doctor, status: :ok
    else
      render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_doctor
    @doctor = Doctor.includes(:chambers, :doctor_schedules, :specializations).find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(
      :bangla_name, :name, :specialty, :display_order,
      :qualification, :experience, :phone,
      :special_notes, :description, :photo_url
    )
  end
end

class Api::V1::DoctorsController < ApplicationController
  # GET /api/v1/doctors
  def index
    doctors = Doctor.all
    render json: doctors
  end

  # GET /api/v1/doctors/:id
  def show
    doctor = Doctor.find(params[:id])
    render json: doctor
  end

  # API Endpoint to fetch doctors by district and specialization (without filtering specialization)
  def filtered_doctors
    # Step 1: Find the district if provided
    district = District.find_by(id: params[:district_id]) if params[:district_id].present?

    # Step 2: Find the specialization based on the specialization_name
    specialization_name = params[:specialization_name]
    specialization = Specialization.find_by(name: specialization_name)

    # If specialization is not found, return error
    unless specialization
      render json: { error: 'Specialization not found' }, status: :not_found and return
    end

    # Step 3: Filter doctors based on district (if provided) and specialization
    if district
      # Fetch doctors in the given district and specialization
      doctors = district.doctors.joins(:doctor_specializations)
                               .where(doctor_specializations: { specialization_id: specialization.id })
    else
      # If no district is provided, fetch doctors based on specialization only
      doctors = Doctor.joins(:doctor_specializations)
                      .where(doctor_specializations: { specialization_id: specialization.id })
    end

    # Step 4: Return the doctors as JSON
    render json: doctors, only: [:id, :name, :degree, :designation], status: :ok
  end

  # POST /api/v1/doctors
  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      render json: @doctor, status: :created
    else
      render json: @doctor.errors, status: :unprocessable_entity
    end
  end

  # METHOD TO GET DOCTORS BY SPECIFICATION ID
  # GET /api/v1/specifications/:specification_id/doctors
  # def by_specification
  #   # Find doctors with the matching specification_id
  #   @doctors = Doctor.where(specification_id: params[:specification_id])

  #   if @doctors.any?
  #     render json: @doctors
  #   else
  #     render json: { error: 'No doctors found with the specified specification' }, status: :not_found
  #   end
  # end

  private

  def doctor_params
    params.require(:doctor).permit(:name, :specialization_id, :display_order, :degree, :expertise,
                                   :designation, :chember, :time, :contact)
  end
end

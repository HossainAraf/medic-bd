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

class Api::V1::DoctorsController < ApplicationController
  # TEST ROUTE
  # def test_route
  #   render json: { message: "Route is working!", params: params }, status: :ok
  # end

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

  # API Endpoint to fetch doctors by district and specialization
  # (without filtering specialization) api/v1/doctors/filtered_doctors
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

    # Return the filtered list of doctors
    render json: doctors, only: %i[id name specialty qualification experience], status: :ok
  end

  # POST /api/v1/doctors
  # def create
  #   @doctor = Doctor.new(doctor_params)
  #   if @doctor.save
  #     render json: @doctor, status: :created
  #   else
  #     Rails.logger.debug("Errors: #{@doctor.errors.full_messages}")
  #     render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end  

  # def create
  #   Rails.logger.info("Doctor Params: #{doctor_params.inspect}")
  #   @doctor = Doctor.new(doctor_params)
  
  #   if @doctor.save
  #     render json: @doctor, status: :created
  #   else
  #     Rails.logger.error("Errors: #{@doctor.errors.full_messages}")
  #     render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
  #   end
  # end  
  def create
    @doctor = Doctor.new(doctor_params)
  
    if @doctor.save
      render json: @doctor.as_json(
        include: {
          chambers: { only: [:id, :name, :category, :address, :district_id] },
          doctor_schedules: { only: [:id, :available_day, :available_time, :contact, :chamber_id] },
          specializations: { only: [:id, :name] }
        }
      ), status: :created
    else
      render json: { errors: @doctor.errors.full_messages }, status: :unprocessable_entity
    end
  end
  
  private

  def doctor_params
    params.require(:doctor).permit(
      :name, :specialty, :order, :qualification, :experience, :phone,
      chambers_attributes: [:name, :category, :address, :district_id], 
      doctor_specializations_attributes: [:specialization_id],
      doctor_schedules_attributes: [:available_day, :available_time, :contact, chamber_attributes: [:name, :category, :address, :district_id]
    ]
    )
  end
end


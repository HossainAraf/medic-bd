class Api::V1::DoctorSchedulesController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique do
    render json: {
      error: "Schedule slot already exists for this doctor, chamber, and day"
    }, status: :unprocessable_entity
  end

  before_action :authorize_request, only: %i[create update destroy]
  before_action :authorize_admin,   only: %i[create update destroy]

  before_action :set_doctor,   only: %i[index create]
  before_action :set_schedule, only: %i[show update destroy]

  # GET /api/v1/doctors/:doctor_id/doctor_schedules
  def index
    render json: @doctor.doctor_schedules.as_json(
      include: {
        chamber: { only: %i[id name category address district_id] 
      },
      only: %[id available_day slot start_time end_time contact chamber_id]
      }
    )
  end

  # GET /api/v1/doctor_schedules/:id
  def show
    render json: @schedule
  end

  # POST /api/v1/doctors/:doctor_id/doctor_schedules
  def create
    schedule = @doctor.doctor_schedules.new(schedule_params)

    if schedule.save
      render json: schedule, status: :created
    else
      render json: { errors: schedule.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /api/v1/doctor_schedules/:id
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: { errors: @schedule.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/doctor_schedules/:id
  def destroy
    @schedule.destroy
    head :no_content
  end

  private

  def set_doctor
    @doctor = Doctor.find_by!(slug: params[:doctor_id])
  end

  def set_schedule
    @schedule = DoctorSchedule.find(params[:id])
  end

  def schedule_params
    params.require(:doctor_schedule).permit(
      :chamber_id,
      :available_day,
      :slot,
      :start_time,
      :end_time,
      :contact
    )
  end
end

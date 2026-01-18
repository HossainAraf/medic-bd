class Api::V1::DoctorSchedulesController < ApplicationController
  rescue_from ActiveRecord::RecordNotUnique do
    render json: {
      error: 'Schedule slot already exists for this doctor, chamber, and day'
    }, status: :unprocessable_content
  end

  before_action :authorize_request, only: %i[create update destroy]
  before_action :authorize_admin, only: %i[create update destroy]

  before_action :set_doctor, only: %i[index create]
  before_action :set_schedule, only: %i[show update destroy]

  # GET /api/v1/doctors/:doctor_id/doctor_schedules
  def index
    render json: @doctor.doctor_schedules.as_json(
      include: {
        chamber: { only: %i[id name category address contact district_id] },
        only: %(id available_day slot start_time end_time chamber_id)
      }
    )
  end

  # GET /api/v1/doctor_schedules/:id
  def show
    render json: @schedule
  end

  # POST /api/v1/doctors/:doctor_id/doctor_schedules
  def create
    schedules = []

    ActiveRecord::Base.transaction do
      params[:doctor_schedule][:available_days].each do |day|
        params[:doctor_schedule][:slots].each do |slot|
          time = params[:doctor_schedule][:times][slot]

          schedules << @doctor.doctor_schedules.create!(
            chamber_id: params[:doctor_schedule][:chamber_id],
            available_day: day,
            slot: slot,
            start_time: time[:start],
            end_time: time[:end]
          )
        end
      end
    end

    render json: schedules, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: e.message }, status: :unprocessable_content
  end

  # PUT /api/v1/doctor_schedules/:id
  def update
    if @schedule.update(schedule_params)
      render json: @schedule
    else
      render json: { errors: @schedule.errors.full_messages },
             status: :unprocessable_content
    end
  end

  # DELETE /api/v1/doctor_schedules/:id
  def destroy
    @schedule.destroy
    head :no_content
  end

  private

  def set_doctor
    doctor_slug = params[:doctor_slug]
    @doctor = Doctor.find_by!(slug: doctor_slug)
  end

  def set_schedule
    @schedule = DoctorSchedule.find(params[:id])
  end

  def schedule_params
    params.expect(
      doctor_schedule: %i[chamber_id
                          available_day
                          slot
                          start_time
                          end_time]
    )
  end
end

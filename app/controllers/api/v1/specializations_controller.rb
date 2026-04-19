class Api::V1::SpecializationsController < ApplicationController
  skip_before_action :authorize_request, only: %i[index show doctors create]

  def index
    specializations = Specialization.all
    specializations = specializations.sort_by(&:id)
    render json: specializations
  end

  def show
    specialization = Specialization.find(params[:id])
    render json: specialization
  end

  def doctors
    @doctors = Doctor.includes(:specializations, doctor_schedules: :chamber)
                     .joins(:specializations)
                     .where(specializations: { id: params[:id] })
                     .distinct

    if @doctors.any?
      render json: @doctors.as_json(
        only: %i[id name],
        include: {
          specializations: { only: %i[id name] },
          doctor_schedules: {
            only: %i[id available_day slot start_time end_time chamber_id],
            include: { chamber: { only: %i[id name category address contact district_id] } }
          }
        }
      )
    else
      render json: { error: 'No doctors found with this specified specialization' }, status: :not_found
    end
  end

  # endpoint: POST /api/v1/specializations
  def create
    specialization = Specialization.new(specialization_params)
    if specialization.save
      render json: specialization, status: :created
    else
      render json: specialization.errors, status: :unprocessable_content
    end
  end

  private

  def specialization_params
    params.expect(specialization: [:name])
  end
end

class Api::V1::SpecificationsController < ApplicationController
  def index
    specifications = Specification.all
    render json: specifications
  end

  def show
    specification = Specification.find(params[:id])
    render json: specification
  end

  def doctors
    # Find doctors with the specified specification_id and include associated data
    @doctors = Doctor.joins(:specification, doctor_schedule: :chember)
                                      .where(specialization_id: params[:id])
                                      .select('doctors*, specializations.name AS specialization_name, chembers.name AS chember_name, doctor_schedule.available_day, doctor_schedule.available_time')

    if @doctors.any?
      render json:  @doctors.as_json(
      only: [:id, :name],
      methods: [:specialization_name, chember_name, available_day, available_time]
    )
    else
      render json:  {error: 'No doctors found with this specified specification'}
    end
  end

  # endpoint: POST /api/v1/specifications
  def create
    specification = Specification.new(specification_params)
    if specification.save
      render json: specification, status: :created
    else
      render json: specification.errors, status: :unprocessable_entity
    end
  end

  private

  def specification_params
    params.require(:specification).permit(:name)
  end
end

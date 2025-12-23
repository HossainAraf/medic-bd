class Api::V1::SpecializationsController < Api::BaseController
  
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
    # Find doctors with the specified specialization_id and include associated data
    @doctors = Doctor.joins(:specialization, doctor_schedule: :chamber)
      .where(specialization_id: params[:id])
      .select('doctors*,
      specializations.name AS specialization_name,
      chambers.name AS chamber_name,
      doctor_schedule.available_day, doctor_schedule.available_time')

    if @doctors.any?
      render json: @doctors.as_json(
        only: %i[id name],
        methods: [:specialization_name, chamber_name, available_day, available_time]
      )
    else
      render json: { error: 'No doctors found with this specified specialization' }
    end
  end

  # endpoint: POST /api/v1/specializations
  def create
    specialization = Specialization.new(specialization_params)
    if specialization.save
      render json: specialization, status: :created
    else
      render json: specialization.errors, status: :unprocessable_entity
    end
  end

  private

  def specialization_params
    params.require(:specialization).permit(:name)
  end
end

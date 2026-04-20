class Api::V1::SpecializationsController < Api::BaseController
  before_action :authorize_admin, except: %i[index show doctors]
  skip_before_action :authorize_request, only: %i[index show doctors]

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
    specialization = Specialization.find(params[:id])
    select_sql = <<~SQL.squish
      doctors.id,
      doctors.name,
      specializations.name AS specialization_name,
      chambers.name AS chamber_name,
      doctor_schedules.available_day,
      doctor_schedules.start_time,
      doctor_schedules.end_time
    SQL

    doctors = Doctor.joins(:specializations, doctor_schedules: :chamber)
      .where(specializations: { id: specialization.id })
      .select(select_sql)

    if doctors.any?
      render json: doctors.map { |doctor|
        {
          id: doctor.id,
          name: doctor.name,
          specialization_name: doctor.specialization_name,
          chamber_name: doctor.chamber_name,
          available_day: doctor.available_day,
          start_time: doctor.start_time,
          end_time: doctor.end_time
        }
      }
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

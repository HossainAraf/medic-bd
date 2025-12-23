class Api::V1::ChambersController < Api::BaseController

  def index
    @chambers = Chamber.includes(:district)
    
    # Retrive contact from associated doctor_schedules
    @chambers = @chambers.joins(:doctor_schedules).select('chambers.*, doctor_schedules.contact AS contact')

    # Filter by district if district_id is provided
    @chambers = @chambers.where(district_id: params[:district_id]) if params[:district_id].present?

    # Filter by category if category is provided
    @chambers = @chambers.where(category: params[:category].split(',').map(&:strip)) if params[:category].present?

    render json: @chambers.as_json(include: { district: { only: [:name] } })
  end
end

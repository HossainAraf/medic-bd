class Api::V1::ChambersController < ApplicationController
  skip_before_action :authorize_request, only: [index]

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

  def create
    @chamber = Chamber.new(chamber_params)
    if @chamber.save
      render json: @chamber, status: :created
    else
      render json: @chamber.errors, status: :unprocessable_entity
    end
  end

  private

  def chamber_params
    params.require(:chamber).permit(:name, :district_id, :address, :category)
  end
end
class Api::V1::ChambersController < ApplicationController
  def index
    @chambers = Chamber.includes(:district)

    # Filter by district if district_id is provided
    @chambers = @chambers.where(district_id: params[:district_id]) if params[:district_id].present?

    # Filter by category if category is provided
    @chambers = @chambers.where(category: params[:category].split(',').map(&:strip)) if params[:category].present?

    render json: @chambers.as_json(include: { district: { only: [:name] } })
  end
end

class Api::V1::ChambersController < ApplicationController
  skip_before_action :authorize_request, only: %i[index]

  def index
    chambers = Chamber.includes(:district)

    # Filter by district if district_id is provided
    chambers = chambers.where(district_id: params[:district_id]) if params[:district_id].present?

    # Filter by category if category is provided
    chambers = chambers.where(category: params[:category].split(',').map(&:strip)) if params[:category].present?

    render json: chambers.as_json(include: { district: { only: [:name] } })
  end

  def create
    @chamber = Chamber.new(chamber_params)
    if @chamber.save
      render json: @chamber, status: :created
    else
      render json: @chamber.errors, status: :unprocessable_content
    end
  end

  private

  def chamber_params
    params.expect(chamber: %i[name district_id address category contact])
  end
end

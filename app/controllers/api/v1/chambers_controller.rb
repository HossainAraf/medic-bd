class Api::V1::ChambersController < Api::BaseController
  before_action :authorize_admin, except: %i[index show]
  skip_before_action :authorize_request, only: %i[index show]
  before_action :set_chamber, only: %i[show update destroy]

  def index
    chambers = Chamber.includes(:district)

    # Filter by district if district_id is provided
    chambers = chambers.where(district_id: params[:district_id]) if params[:district_id].present?

    # Filter by category if category is provided
    chambers = chambers.where(category: params[:category].split(',').map(&:strip)) if params[:category].present?

    render json: chambers.as_json(include: { district: { only: [:name] } })
  end

  def show
    render json: @chamber.as_json(include: { district: { only: [:name] } })
  end

  def create
    @chamber = Chamber.new(chamber_params)
    if @chamber.save
      render json: @chamber, status: :created
    else
      render json: @chamber.errors, status: :unprocessable_content
    end
  end

  def update
    if @chamber.update(chamber_params)
      render json: @chamber, status: :ok
    else
      render json: { errors: @chamber.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @chamber.destroy
    head :no_content
  end

  private

  def set_chamber
    @chamber = Chamber.find_by(id: params[:id])
    return if @chamber # If chamber is found, exit the method OR use find_by! to raise exception

    render json: { error: 'Chamber not found' }, status: :not_found unless @chamber
  end

  def chamber_params
    params.expect(chamber: %i[name district_id address category contact])
  end
end

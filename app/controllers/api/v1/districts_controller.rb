class Api::V1::DistrictsController < Api::BaseController
  before_action :authorize_admin, except: %i[index show]
  skip_before_action :authorize_request, only: %i[index show]
  before_action :set_district, only: %i[show update destroy]

  def index
    districts = District.all
    render json: districts, only: %i[id name]
  end

  def show
    render json: @district, only: %i[id name]
  end

  def create
    district = District.new(district_params)

    if district.save
      render json: district, status: :created
    else
      render json: { errors: district.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @district.update(district_params)
      render json: @district, status: :ok
    else
      render json: { errors: @district.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @district.destroy
    head :no_content
  end

  private

  def set_district
    @district = District.find(params[:id])
  end

  def district_params
    params.expect(district: [:name])
  end
end

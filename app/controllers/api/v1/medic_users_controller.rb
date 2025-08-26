class Api::V1::MedicUsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create]

  # POST /api/v1/medic_users
  def create
    user = MedicUser.new(user_params)
    if user.save
      token = JsonWebToken.encode(user_id: user.id)
      render json: { token: token, user: user_response(user) }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /api/v1/medic_users
  def index
    users = MedicUser.all
    render json: users.map { |user| user_response(user) }, status: :ok
  end

  private

  def user_params
    params.require(:medic_user).permit(:name, :email, :phone, :password, :password_confiramtion, :role)
  end

  def user_response(user)
    user.as_json(only: %i[id name email phone role created_at updated_at])
  end
end

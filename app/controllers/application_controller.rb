class ApplicationController < ActionController::API
  # before_action :authorize_request

  private

  def authorize_request
    header = request.headers['Authorization']
    token = header.split.last if header
    payload = JsonWebToken.decode(token)
    @current_user = MedicUser.find_by(id: payload[:user_id]) if payload

    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end

  attr_reader :current_user
end

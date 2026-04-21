class Api::BaseController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  protected

  def authorize_request
    @current_user = authenticate_user_from_token
    return if @current_user

    render json: { error: 'Not Authorized' }, status: :unauthorized
  end

  def authorize_admin
    return if @current_user&.role == 'admin'

    render json: { error: 'Forbidden: Admins only' }, status: :forbidden
  end

  private

  def authenticate_user_from_token
    token = extract_token_from_header
    return nil unless token

    payload = decode_token(token)
    MedicUser.find_by(id: payload[:user_id]) if payload
  rescue JWT::DecodeError => e
    log_debug("JWT Decode Error: #{e.message}")
    render json: { error: 'Invalid token' }, status: :unauthorized
    nil
  rescue StandardError => e
    log_debug("Other Error: #{e.message}")
    render json: { error: 'Token error' }, status: :unauthorized
    nil
  end

  def extract_token_from_header
    request.headers['Authorization']&.split&.last
  end

  def decode_token(token)
    JsonWebToken.decode(token)
  end

  def log_debug(message)
    Rails.logger.debug { "[API AUTH] #{message}" }
  end
end

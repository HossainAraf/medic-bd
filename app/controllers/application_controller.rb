class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  # Public method for admin authorization(used as callback)
  def authorize_admin
    render json: { error: 'Forbidden: Admins only' }, status: :forbidden unless @current_user&.role == 'admin'
  end

  private

  def authorize_request
    @current_user = authenticate_user_from_token
    
    return if @current_user

    log_debug('Current user is NIL')
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
  
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
    header = request.headers['Authorization']
    log_debug("Authorization Header: #{header}")
    header&.split&.last
  end
  
  def decode_token(token)
    log_debug("Extracted Token: #{token}")
    payload = JsonWebToken.decode(token)
    log_debug("Decoded Payload: #{payload.inspect}")
    payload
  end

  def log_debug(message)
    puts "DEBUG: #{message}"
  end 
end

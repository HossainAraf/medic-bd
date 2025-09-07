class ApplicationController < ActionController::API
  before_action :authorize_request
  attr_reader :current_user

  # Public method for admin authorization(used as callback)
  def authorize_admin
    render json: { error: 'Forbidden: Admins only' }, status: :forbidden unless @current_user&.role == 'admin'
  end

  private

def authorize_request
  header = request.headers['Authorization']
  puts "DEBUG: Authorization Header: #{header}" # Debug line

  token = header.split.last if header
  puts "DEBUG: Extracted Token: #{token}" # Debug line

  begin
    payload = JsonWebToken.decode(token)
    puts "DEBUG: Decoded Payload: #{payload.inspect}" # Debug line

    @current_user = MedicUser.find_by(id: payload[:user_id]) if payload
    puts "DEBUG: Current User: #{@current_user.inspect}" # Debug line

  rescue JWT::DecodeError => e
    puts "DEBUG: JWT Decode Error: #{e.message}" # Debug line
    render json: { error: 'Invalid token' }, status: :unauthorized
    return
  rescue => e
    puts "DEBUG: Other Error: #{e.message}" # Debug line
    render json: { error: 'Token error' }, status: :unauthorized
    return
  end

  unless @current_user
    puts "DEBUG: Current user is NIL" # Debug line
    render json: { error: 'Not Authorized' }, status: :unauthorized
  end
end

end

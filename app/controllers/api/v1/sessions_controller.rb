module Api
  module V1
    class SessionsController < Api::BaseController
      
      # POST /api/v1/auth/login
      def create
        email = params.dig(:medic_user, :email)&.downcase
        password = params.dig(:medic_user, :password)

        user = MedicUser.find_by(email: email)
        if user&.authenticate(password)
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token: token, user: { id: user.id, name: user.name, email: user.email, role: user.role } },
                 status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end

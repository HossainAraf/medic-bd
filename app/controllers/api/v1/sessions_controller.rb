module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authorize_request, only: [:create]

      # POST /api/v1/auth/login
      def create
        user = MedicUser.find_by(email: params[:email]&.downcase)
        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          render json: { token:, user: { id: user.id, name: user.name, email: user.email, role: user.role } },
                 status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end
    end
  end
end

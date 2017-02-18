module Api::V1
  class AuthenticationController < Api::V1::BaseController
    skip_before_action :authenticate_request, only: [:authenticate]

    def authenticate
      command = AuthenticateUser.call(params[:email], params[:password])

      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    end

    def logout
      @current_user.last_logout_at = DateTime.now
      if @current_user.save
        render json: { message: 'Logged out' }
      else
        render json: { error: @current_user.error_messages }, status: :unprocessable_entity
      end
    end
  end
end

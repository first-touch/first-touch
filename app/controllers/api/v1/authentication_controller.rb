module Api
  module V1
    class AuthenticationController < Api::V1::BaseController
      skip_before_action :authenticate_request, only: %i[authenticate validate]

      def authenticate
        res = ::V1::User::SignIn.(auth_params)
        response = FirstTouch::Endpoint.(res, ::V1::User::Representer::Authenticated)
        render json: response[:data], status: response[:status]
      end

      def logout
        @current_user.last_logout_at = Time.now
        if @current_user.save
          render json: { message: 'Logged out' }
        else
          render json: { error: @current_user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      private

      def auth_params
        params.permit(:email, :password)
      end
    end
  end
end

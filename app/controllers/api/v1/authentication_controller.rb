module Api
  module V1
    class AuthenticationController < Api::V1::BaseController
      skip_before_action :authenticate_request,
                         only: %i[authenticate reset_password update_password]

      def authenticate
        res = ::V1::User::SignIn.(auth_params)
        representer = ::V1::User::Representer::Authenticated
        unauthenticated = {
          resolve: lambda do |_result, _representer|
            { "data": { errors: I18n.t('user.invalid_credentials') },
              "status": :unauthorized }
          end
        }
        response = FirstTouch::Endpoint.(res, representer,
                                         unauthenticated: unauthenticated)
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

      def reset_password
        ::V1::User::ResetPassword.(auth_params)
        render json: { message: I18n.t('user.reset_password') }, status: :ok
      end

      def update_password
        res = ::V1::User::UpdatePassword.(auth_params, headers: request.headers)
        representer = ::V1::User::Representer::PasswordUpdated
        response = FirstTouch::Endpoint.(res, representer)
        render json: response[:data], status: response[:status]
      end

      private

      def auth_params
        params.permit(:email, :password, :password_confirmation)
      end
    end
  end
end

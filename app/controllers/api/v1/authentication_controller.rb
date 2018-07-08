module Api
  module V1
    class AuthenticationController < Api::V1::BaseController
      skip_before_action :authenticate_request, only: %i[authenticate validate]

      def authenticate
        res = ::V1::User::SignIn.(auth_params)
        response = FirstTouch::Endpoint.(res, ::V1::User::Representer::Authenticated)
        render json: response[:data], status: response[:status]

        # command = AuthenticateUser.(auth_params[:email], auth_params[:password])

        # if command.success?
        #   render json: { auth_token: command.result }
        # else
        #   render json: { error: command.errors[:user_authentication] }, status: :unauthorized
        # end
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

      def validate
        token_expired = ValidateToken.(request.headers).result
        if token_expired
          current_user = AuthorizeApiRequest.(request.headers).result
          if current_user
            new_token = JsonWebToken.encode(
              user_id: current_user.id,
              digest: current_user.password_digest,
              last_logout: current_user.last_logout_at.to_i
            )
            render json: { auth_token: new_token }
          else
            render json: { error: 'Not Authorized' }, status: :unauthorized
          end
        else
          render json: true, status: :ok
        end
      end

      private

      def auth_params
        params.permit(:email, :password)
      end
    end
  end
end

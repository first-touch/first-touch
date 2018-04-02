module Api
  module V1
    class PasswordResetController < Api::V1::BaseController
      skip_before_action :authenticate_request, only: [:start_process]

      def start_process
        result = ::V1::PasswordReset::Request.(params)
        resolve_failure = ->(_result, _representer) do
          { 'data': {}, 'status': :ok }
        end
        response = FirstTouch::Endpoint.(
          result,
          nil,
          invalid: { resolve: resolve_failure }
        )
        render json: response[:data], status: response[:status]
      end

      def update
        result = FirstTouch::Endpoint.(
          ::V1::PasswordReset::Update,
          args: [params]
        )
        render json: result[:data], status: result[:status]
      end

      def get_form
        result = FirstTouch::Endpoint.(
          ::V1::PasswordReset::Form,
          args: [params]
        )
        render json: result[:data], status: result[:status]
      end
    end
  end
end

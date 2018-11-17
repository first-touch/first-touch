module Api
  module V1
    class ConnectionController < Api::V1::BaseController
      def create
        result = ::V1::Connection::DoubleCreate.(params: params,
                                                 current_user: current_user)
        if result.failure?
          messages = result['contract.default'].errors.full_messages
          render json: { error: messages },
                 status: :unprocessable_entity
        else
          render json: result[:model], status: :ok
        end
      end
    end
  end
end

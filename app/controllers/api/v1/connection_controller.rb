module Api
  module V1
    class ConnectionController < Api::V1::BaseController
      def create
        result = ::V1::Connection::DoubleCreate.(params: params,
                                                 current_user: current_user)
        response = FirstTouch::Endpoint.(result)
        render json: response[:data], status: response[:status]
      end

      def index
        op = ::V1::Network::Index.(params: params, current_user: @current_user)
        response = FirstTouch::Endpoint.(op, ::V1::Network::Representer::Index)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

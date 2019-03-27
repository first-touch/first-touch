module Api
  module V1
    class NetworkController < Api::V1::BaseController
      def index
        op = ::V1::Network::Index.(params: params, current_user: @current_user)
        response = FirstTouch::Endpoint.(op, ::V1::Network::Representer::Index)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

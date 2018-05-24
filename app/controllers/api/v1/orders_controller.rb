require './lib/payment_util'

module Api
  module V1
    class OrdersController < Api::V1::BaseController
      # TODO: will change once stripe is set
      def create
        result = ::V1::Report::Buy.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Order::Representer::Empty)
        render json: response[:data], status: response[:status]
      end

      def refund
        result = ::V1::Order::Refund.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Order::Representer::Empty)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

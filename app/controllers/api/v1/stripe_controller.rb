module Api
  module V1
    class StripeController < Api::V1::BaseController

      def index
        result = ::V1::Stripe::Show.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Stripe::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::Stripe::Create.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Order::Representer::Empty)
        render json: response[:data], status: response[:status]
      end

      def required
        result = ::V1::Stripe::FieldNeeded.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Stripe::Representer::FieldNeeded)
        render json: response[:data], status: response[:status]
      end

    end
  end
end

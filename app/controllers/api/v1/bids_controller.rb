module Api
  module V1
    class BidsController < Api::V1::BaseController
      def update
        result = ::V1::RequestBid::Update.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::Request::AddBids.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def request_bids
        result = ::V1::RequestBid::Index.(param, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def accept_bid
        result = ::V1::Request::AcceptBid.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

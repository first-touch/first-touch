module Api
  module V1
    class BidsController < Api::V1::BaseController
      def update
        result = ::V1::RequestBid::Update.(params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::Request::AddBids.(params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def destroy
        result = ::V1::RequestBid::Cancel.(params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::Order::Representer::Empty)
        render json: response[:data], status: response[:status]
      end

      def requestbids
        result = ::V1::RequestBid::Index.(params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def acceptbid
        result = ::V1::Request::AcceptBid.(params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

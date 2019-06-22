# TODO: Deprecated. To be deleted once its guaranteed that nothing relies on this
module Api
  module V1
    class BidsController < Api::V1::BaseController
      def requestbids
        result = ::V1::RequestBid::Index.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def acceptbid
        result = ::V1::Request::AcceptBid.(params: params, current_user: current_user, current_club: @current_club)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

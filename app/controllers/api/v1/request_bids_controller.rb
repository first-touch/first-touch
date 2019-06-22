# TODO: Deprecated. Controller for request bids is scoped by user
# role. This controller should be deleted
module Api
  module V1
    class RequestBidsController < Api::V1::BaseController
      def index
        # TODO: Figure out why the user representer is not sending the user
        # with the correct attributes - e.g sending auth token
        result = ::V1::RequestBid::Index.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::RequestBid::Create.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

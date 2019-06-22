module Api
  module V1
    module Scout
      class RequestBidsController < Api::V1::BaseController
        def index
          result = ::V1::RequestBid::Operation::Scout::Index.(params: params, current_user: current_user)
          response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Index)
          render json: response[:data], status: response[:status]
        end

        # TODO: When updating the status, we might need to trigger some
        # side effects. Might make more sense to have a separate
        # endpoint later on
        def update
          result = ::V1::RequestBid::Update.(params: params, current_user: current_user)
          response = FirstTouch::Endpoint.(result, ::V1::RequestBid::Representer::Full)
          render json: response[:data], status: response[:status]
        end
      end
    end
  end
end

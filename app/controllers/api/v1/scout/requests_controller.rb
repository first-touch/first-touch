module Api
  module V1
    module Scout
      class RequestsController < Api::V1::BaseController
        def index
          result = ::V1::Request::Operation::Scout::Index.(params: params, current_user: current_user)
          response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Index)
          render json: response[:data], status: response[:status]
        end
      end
    end
  end
end

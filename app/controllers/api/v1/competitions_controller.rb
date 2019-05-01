module Api
  module V1
    class CompetitionsController < Api::V1::BaseController
      def index
        result = ::V1::Competition::Index.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Competition::Representer::Index)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

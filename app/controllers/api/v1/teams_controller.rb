module Api
  module V1
    class TeamsController < Api::V1::BaseController
      def index
        result = ::V1::Team::Index.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Team::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def show
        result = ::V1::Team::Show.(params: params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Team::Representer::Simplified)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

module Api
  module V1
    class TeamsController < Api::V1::BaseController
      def index
        result = ::V1::Team::Index.(params, current_user: current_user)
        render json: result['models'], status: :ok
      end

      def show
        result = ::V1::Team::Show.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Team::Representer::Simplified)
        render json: response[:data], status: response[:status]
      end
    end
  end
end

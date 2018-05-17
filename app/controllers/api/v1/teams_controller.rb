module Api
  module V1
    class TeamsController < Api::V1::BaseController

      def index
        result = ::V1::Team::Index.(params, current_user: current_user)
        render json: result['models'], status: :ok
      end

    end
  end
end

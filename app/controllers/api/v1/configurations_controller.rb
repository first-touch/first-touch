module Api
  module V1
    class ConfigurationsController < Api::V1::BaseController
      skip_before_action :authenticate_request, only: %i[playing_positions]
      def playing_positions
        render json: FirstTouch::PLAYING_POSITIONS, status: :ok
      end
    end
  end
end

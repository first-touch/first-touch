module Api
  module V1
    class ClubsController < Api::V1::BaseController
      skip_before_action :authenticate_request, only: %i[index search show countries]
      def index
        result = ::V1::Club::Index.(params)
        response = FirstTouch::Endpoint.(result, ::V1::Club::Representer::Search)
        render json: response[:data], status: response[:status]
      end

      def show
        result = ::V1::Club::Show.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Club::Representer::Show)
        render json: response[:data], status: response[:status]
      end

      def search
        index
      end

      def countries
        result = ::V1::Club::Countries.()
        response = FirstTouch::Endpoint.(result, ::V1::Club::Representer::Countries)
        render json: response[:data], status: response[:status]
      end

      def import_roster
        result = ::V1::Club::ImportRoster.(params)
        if result.failure?
          render json: { error_message: result['errors'] },
                 status: :unprocessable_entity

        else
          render json: { message: 'File being processed and will be available soon' },
                 status: :ok
        end
      end
    end
  end
end

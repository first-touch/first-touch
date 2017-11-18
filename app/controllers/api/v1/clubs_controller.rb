module Api
  module V1
    class ClubsController < Api::V1::BaseController
      def search
        result = ::V1::Club::Index.(params)
        if result.failure?
          render json: { error_message: result['errors'] },
                 status: :unprocessable_entity

        else
          render json: ::V1::Club::Representer::Search.new(result['models']),
                 status: :ok
        end
      end
    end
  end
end

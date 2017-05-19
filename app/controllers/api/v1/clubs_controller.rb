module Api
  module V1
    class ClubsController < Api::V1::BaseController
      def search
        result = ::Club::Index.call(params)
        if result.failure?
        else
          render json: Api::V1::Club::Representer::Search.new(result['model']),
                 status: :ok
        end
      end
    end
  end
end

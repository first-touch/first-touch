module Api
  module V1
    class ClubsController < Api::V1::BaseController
      def show
        result = ::V1::Club::Show.(params, current_user: current_user)
        if result.success?
          render json: ::V1::Club::Representer::Full.new(result['model']),
                 status: :ok
        elsif result.policy_error?
          render json: {}, status: :unauthorized
        else
          error_messages = result['contract.default']&.errors&.full_messages || result['result.model']
          render json: { errors: error_messages }, status: :unprocessable_entity
        end
      end

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

      def import_roster
        result = ::V1::Club::ImportRoster.(params)
        if result.failure?
          render json: { error_message: result['errors'] },
                 status: :unprocessable_entity

        else
          render json: { message: 'File being processed and will be available soon'},
                 status: :ok
        end
      end
    end
  end
end

module Api
  module V1
    class EventsController < Api::V1::BaseController
      def create
        result = ::V1::Event::Create.(params, current_user: current_user)
        if result.success?
          render json: ::V1::Event::Representer::Full.new(
            result['model']
          ), status: :created
        elsif result['result.policy.failure'] == :unauthorized
          render json: { error: 'Unauthorized' }, status: :unauthorized
        else
          render json: {
            error: result['contract.default'].errors.full_messages
          },
                 status: :unprocessable_entity
        end
      end
      
      def index
        result = ::V1::Event::Index.(params, current_user: current_user)
        render json: ::V1::Event::Representer::Index.new(result['models'])
      end
    end
  end
end

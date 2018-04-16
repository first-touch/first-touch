module Api
  module V1
    class RequestsController < Api::V1::BaseController
      def index
        result = ::V1::Request::Index.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Index)
        render json: response[:data], status: response[:status]
      end

      def show
        result = ::V1::Request::Show.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
        render json: response[:data], status: response[:status]
      end

      def create
        result = ::V1::Request::Create.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
          render json: response[:data], status: response[:status]
        elsif result['result.policy.failure'] == :unauthorized
          render json: { error: 'Unauthorized' }, status: :unauthorized
        else
          render json: {
            error: result['contract.default'].errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      def update
        result = ::V1::Request::Update.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
          render json: response[:data], status: response[:status]
        elsif result['contract.default'].blank?
          render json: { error: result['result.model.errors'] }, status: :unprocessable_entity
        else
          render json: {
            error: result['contract.default'].errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end
end

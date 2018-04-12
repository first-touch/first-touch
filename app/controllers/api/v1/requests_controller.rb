module Api
  module V1
    class RequestsController < Api::V1::BaseController
      def index
        result = ::V1::Request::Index.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Index)
          render json: response[:data], status: response[:status]
        else
          render json: { error: 'Not Found' }, status: :not_found
        end
      end

      def show
        result = ::V1::Request::Show.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
          render json: response[:data], status: response[:status]
        else
          render json: {
          }, status: :unauthorized
        end
      end

      def create
        result = ::V1::Request::Create.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
          render json: response[:data], status: response[:status]
        else
          errors = result['contract.default'].blank? ?
            ['sometings is wrong with your request'] :
            result['contract.default'].errors.full_messages
          render json: { success: false, errors: errors }, status: :bad_request
        end
      end

      def update
        result = ::V1::Request::Update.(params, current_user: current_user)
        if result.success?
          response = FirstTouch::Endpoint.(result, ::V1::Request::Representer::Full)
          render json: response[:data], status: response[:status]
        else
          render json: {
            error: result['contract.default'].blank? ?
              'Sorry but something went wrong' :
              result['contract.default'].errors.full_messages
          }, status: :unprocessable_entity
        end
      end
    end
  end
end

module Api
  module V1
    module Users
      class PostsController < Api::V1::BaseController
        def index
          result = ::V1::Post::PersonalFeed.(params, current_user: current_user)
          response = FirstTouch::Endpoint.(result, ::V1::Post::Representer::Index)
          render json: response[:data], status: response[:status]
        end

        def create
          result = ::V1::Post::Create.(params, current_user: current_user)
          if result.success?
            render json: ::V1::Post::Representer::Full.new(result['model']),
                   status: :created
          elsif result['result.policy.failure'] == :unauthorized
            render json: { error: 'Unauthorized' }, status: :unauthorized
          else
            render json: {
              error: result['contract.default'].errors.full_messages
            }, status: :unprocessable_entity
          end
        end
      end
    end
  end
end

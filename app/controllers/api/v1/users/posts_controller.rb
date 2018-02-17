module Api
  module V1
    module Users
      class PostsController < Api::V1::BaseController
        def index
          # Build feed
          render json: { posts: current_user.feed }, status: :ok
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

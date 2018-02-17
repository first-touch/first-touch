module Api
  module V1
    module Clubs
      class PostsController < Api::V1::ClubBaseController
        def index
          # Build feed
          render json: @current_club.feed
        end

        def create
          result = ::V1::Post::Create.(params, current_user: @current_club)
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

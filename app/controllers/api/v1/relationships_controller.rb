module Api
  module V1
    class RelationshipsController < Api::V1::BaseController
      def create
        user = User.find(params[:followed_id])
        unless user
          # 422: server understands the content type of the request entity,
          # and the syntax of the request entity is correct,
          # but was unable to process the contained instructions
          render json: { error: 'User to follow not found' }, status: :unprocessable_entity
          return
        end
        relationship = current_user.follow(user)
        if relationship
          render json: relationship
        else
          render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        relationship = Relationship.find(params[:id])
        unless relationship
          render json: { error: 'You are not following this user' }, stauts: :uprocessable_entity
          return
        end
        user = relationship.followed
        if current_user.unfollow(user)
          render json: { relationship: nil }
        else
          render json: { error: current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end
    end
  end
end

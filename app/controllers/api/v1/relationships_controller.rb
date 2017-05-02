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
        relationship = @current_user.follow(user)
        if relationship
          render json: relationship
        else
          render json: { error: @current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        followed_user = User.find destroy_params[:followed_user_id]
        unless @current_user.following? followed_user
          render json: { error: 'You are not following this user' }, stauts: :uprocessable_entity
          return
        end
        
        if @current_user.unfollow(followed_user)
          render json: { relationship: nil }
        else
          render json: { error: @current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
      private
      
      def destroy_params
        params.permit(:followed_user_id)
      end
    end
  end
end

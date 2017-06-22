# TOOD: Write tests
module Api
  module V1
    class PostsController < Api::V1::BaseController
      def index
        # Build feed
        render json: @current_user.feed
      end

      def create
        new_post = Post.new post_params
        new_post.user = @current_user
        if new_post.save
          render json: new_post
        else
          render json: { error: new_post.errors.full_messages },
                 status: :unprocesseable_entity
        end
      end

      def destroy
        render json: {}
      end

      def update
        render json: {}
      end

      private

      def post_params
        params.require(:post).permit(
          :content,
          {
            images_attributes: [
              :file
            ]
          }
        )
      end
    end
  end
end

class Api::V1::PostsController < Api::V1::BaseController
  def index
    render json: {}
  end

  def create
    if current_user.id.to_s == params[:post][:user_id]
      new_post = Post.new post_params
      if new_post.save
        render json: new_post
      else
        render json: {}, status: :unprocesseable_entity
      end
    else
      render json: {}, status: :unauthorized
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
    params.require(:post)
      .permit([
                :user_id,
                :content,
                :id
              ])
  end
end

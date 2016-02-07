class Api::V1::UsersController < Api::V1::BaseController
  before_filter :find_user, only: [:show]

  def show
    render json: @user.as_json
  end

  private
  def find_user
    @user = User.find params[:id]
  end
end

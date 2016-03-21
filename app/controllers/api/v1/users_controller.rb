class Api::V1::UsersController < Api::V1::BaseController
  before_filter :find_user, only: [:show, :update]

  def show
    render json: @user
  end

  def update
    @user.update_attributes user_params
    if @user.save
      render json: @user
    else
      render json: { errors: @user.errors.all }, status: :unprocesseable_entity
    end
  end

  private

  def find_user
    @user = User.find params[:id]
  end

  def user_params
    params.require(:user)
      .permit(personal_profile_attributes: [
                :first_name,
                :middle_name,
                :last_name,
                :birthday,
                :achievements,
                :languages,
                :nationality_country_code,
                :residence_country_code,
                :summary
              ])
  end
end

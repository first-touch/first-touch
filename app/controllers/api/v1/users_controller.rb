class Api::V1::UsersController < Api::V1::BaseController
  before_action :find_user, only: [:show, :update, :follows]

  def show
    if @user
      # TODO: This should decide wether rendering public profile data or private profile data
      # depending on privacy definitions.
      render json: @user
    else
      render json: { error: 'User not found' }, status: :unprocessable_entity
    end
  end

  def update
    @user.update_attributes user_params
    if @user.save
      render json: @user
    else
      render json: { error: @user.errors.all }, status: :unprocessable_entity
    end
  end

  def follows
    relationship = @user.active_relationships.find_by followed_id: params[:followed_id]
    relationship = { relationship: nil } if relationship.nil?
    render json: relationship
  end

  def search
    query_params = params[:q]
    user_list = User.where('search_string ILIKE ?', "%#{query_params}%").limit 5
    render json: user_list, each_serializer: Users::SearchSerializer
  end

  private

  def find_user
    begin
      @user = User.find params[:id]
    rescue ActiveRecord::RecordNotFound => e
      @user = nil
    end
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

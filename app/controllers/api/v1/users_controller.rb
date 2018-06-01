module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :authenticate_request, only: [:register]
      before_action :find_user, only: %i[public_profile follows]
      before_action :track_view, only: [:public_profile]

      def register
        result = ::V1::User::Register.(params)
        if result.failure?
          messages = result['contract.default'].errors.full_messages
          render json: { error: messages },
                 status: :unprocessable_entity
        else
          render json: result['model'], status: :ok
        end
      end

      def show
        render json: ::V1::User::Representer::SelfProfile.new(@current_user)
      end

      def public_profile
        result = ::V1::User::Show.(params, current_user: current_user)
        if result.failure?
          render json: { error: 'User not found' },
                 status: :unprocessable_entity
        else
          render json: result['response'], status: :ok
        end
      end

      def update
        result = ::V1::User::Update.(params, current_user: current_user)
        response = FirstTouch::Endpoint.(result, ::V1::User::Representer::SelfProfile)
        render json: response[:data], status: response[:status]
      end

      def follows
        relationship = @user.active_relationships.find_by(
          followed_id: params[:followed_id]
        )
        relationship = { relationship: nil } if relationship.nil?
        render json: relationship
      end

      def search
        result = ::V1::User::Index.(params, current_user: current_user)
        if result.failure?
          render json: { error_message: result['errors'] },
                 status: :unprocessable_entity
        else
          render json: result['models'],
                 each_serializer: ::Users::SearchSerializer,
                 status: :ok
        end
      end

      def club_token
        result = ::V1::User::ClubToken.(params, current_user: current_user)
        if result.failure?
          render json: { error_message: result.errors },
                 status: :unprocessable_entity
        else
          render json: result['model'], status: :ok
        end
      end

      private

      def find_user
        @user = ::User.find_by id: params[:id]
      end

      def user_params
        params.require(:user)
              .permit(
                personal_profile_attributes: %i[
                  id
                  first_name
                  middle_name
                  last_name
                  birthday
                  achievements
                  languages
                  nationality_country_code
                  residence_country_code
                  summary
                  height
                  place_of_birth
                  preferred_foot
                  weight
                ],
                career_entries_attributes: %i[
                  start_date
                  end_date
                  club_id
                  club_name
                  role
                ]
              )
      end
    end
  end
end

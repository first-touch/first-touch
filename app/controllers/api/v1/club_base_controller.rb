module Api
  module V1
    class ClubBaseController < ApplicationController
      # NOTE: This is generally a bad practice for rails apps. Strong parameters
      # were introduced for avoiding client side injecting. Still, we are using
      # Trailblazer which relies on form builders. As long as ALL your
      # api endpoints use Trailblazer, then its fine.
      # If you are not using Trailblazer architecture and
      # Form building approach, then you MUST validate the params and therefore
      # skip this action
      before_action :permit_all_params

      private

      # TODO: Follow trailblazer auth logic
      def authenticate_request
        result = AuthorizeClubRequest.(request.headers).result
        @current_user = result[:user]
        @current_club = result[:club]
        return unless @current_club.account_owner != @current_user
        render json: { error: 'Not Authorized' }, status: :unauthorized
      end

      def permit_all_params
        params.permit!
      end

      def track_view
        # FIXME: Find a better way of mapping this:
        return if params[:action] != 'public_profile'
        type = Statistic::PROFILE_VIEW
        metadata = {
          requested_profile_id: params[:id],
          requested_profile_type: 'User',
          requested_by_id: current_user.id,
          requested_by_type: 'User',
          requested_time: Time.now.utc.strftime('%F %T')
        }
        Statistics::TrackRequest.perform_async(type, metadata)
      end
    end
  end
end

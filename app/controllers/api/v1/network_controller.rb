module Api
  module V1
    class NetworkController < Api::V1::BaseController
      def index
        # TODO: Needs improvement as network grows
        # will probably be impossible to build the whole graph at once
        followers = @current_user.followers.as_json(only: [:id],
                                                   methods: [:full_name])

        following = @current_user.followers.as_json(only: [:id],
                                                   methods: [:full_name])
        render json: { network:
                         {
                           followers: followers,
                           following: following
                         } }
      end
    end
  end
end

module Api
  module V1
    class NetworkController < Api::V1::BaseController
      def index
        render json: { message: 'Deprecated' }, status: :ok
        # TODO: Needs improvement as network grows
        # will probably be impossible to build the whole graph at once
        # network_attrs = {
        #   followers: @current_user.followers,
        #   following: @current_user.following
        # }
        # network = Network.new(network_attrs)

        # render json: NetworkSerializer.new(network), root: 'network'
      end
    end
  end
end

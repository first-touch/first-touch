module Api
  module V1
    class NetworkController < Api::V1::BaseController
      def index
        op = ::V1::Network::Index.(params: params, current_user: @current_user)
        response = FirstTouch::Endpoint.(op, ::V1::Network::Representer::Index)
        render json: response[:data], status: response[:status]

        # render json: { message: 'Deprecated' }, status: :ok
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

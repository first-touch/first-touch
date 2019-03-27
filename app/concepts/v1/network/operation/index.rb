module V1
  module Network
    class Index < FirstTouch::Operation
      step :build_network

      private

      def build_network(options, current_user:, **)
        options[:models] = ::Connection.status_accepted
                                       .where(user_id: current_user.id)
                                       .map(&:connected_to)
      end
    end
  end
end

module V1
  module Network
    class Index < FirstTouch::Operation
      step :build_network

      private

      def build_network(options, current_user:, **)
        options[:models] = ::Connection.where(user_id: current_user.id)
      end
    end
  end
end

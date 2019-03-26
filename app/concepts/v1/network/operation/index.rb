module V1
  module Network
    class Index < FirstTouch::Operation
      step :build_network

      private

      def build_network(options, params:, current_user:, **)
        options[:connections] = ::Connection.where(user_id: current_user.id)
      end
    end
  end
end

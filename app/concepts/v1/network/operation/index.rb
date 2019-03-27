module V1
  module Network
    class Index < FirstTouch::Operation
      step :build_network
      step :filter_by_role
      step :build_results

      private

      def build_network(options, current_user:, **)
        options[:network] = ::Connection.status_accepted
                                        .where(user_id: current_user.id)
      end

      def filter_by_role(options, params:, **)
        return true unless params[:role].present?

        options[:network] = options[:network].includes(connected_to: :roles)
                                             .where(roles: { name: params[:role] })
      end

      def build_results(options, **)
        options[:models] = options[:network].map(&:connected_to)
      end
    end
  end
end

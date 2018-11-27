module V1
  module Connection
    class DoubleCreate < Trailblazer::Operation
      step :create_connections!
      step :build_response!
      step :notify_user!

      def create_connections!(options, params:, current_user:, **)
        user_params = {
          user_id: current_user.id,
          connected_to_id: params[:connected_to_id]
        }
        user_connection = Create.(
          params: user_params,
          current_user: current_user
        )

        friend_params = {
          user_id: params[:connected_to_id],
          connected_to_id: current_user.id
        }
        friend_connection = Create.(
          params: friend_params,
          current_user: current_user
        )

        options[:results] = {
          user: user_connection,
          friend: friend_connection
        }
      end

      def build_response!(options, results:, **)
        user = results[:user]
        friend = results[:friend]
        if user.success? && friend.success?
          options[:model] = user[:model]
          true
        elsif user.failure?
          options['contract.default'] = user['contract.default']
          false
        else
          options['contract.default'] = friend['contract.default']
          false
        end
      end

      def notify_user!(_opts, params:, **)
        NotificationCenter.send_notification(
          'connection_requested',
          { user_name: options[:current_user].display_name },
          params[:connected_to_id]
        )
      end
    end
  end
end

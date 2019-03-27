module V1
  module Connection
    class DoubleCreate < FirstTouch::Operation
      step :create_user_one_connection
      failure :error_creating_connection, fail_fast: true
      step :create_user_two_connection
      failure :error_creating_connection, fail_fast: true
      step :notify_user

      def create_user_one_connection(options, params:, current_user:, **)
        conn_params = {
          user_id: current_user.id,
          connected_to_id: params[:connected_to_id],
          status: 'requested'
        }
        options[:user] = Create.(
          params: conn_params, current_user: current_user
        )
        options[:user].success?
      end

      def create_user_two_connection(options, params:, current_user:, **)
        conn_params = {
          user_id: params[:connected_to_id],
          connected_to_id: current_user.id,
          status: 'pending'
        }
        options[:friend] = Create.(
          params: conn_params, current_user: current_user
        )
        options[:friend].success?
      end

      def error_creating_connection(options, **)
        options['contract.default'] = if options[:user].failure?
                                        options[:user].errors
                                      else
                                        options[:friend].errors
                                      end
      end

      def notify_user(_opts, params:, current_user:, **)
        NotificationCenter.send_notification(
          'connection_requested',
          { user_name: current_user.display_name },
          params[:connected_to_id]
        )
      end
    end
  end
end

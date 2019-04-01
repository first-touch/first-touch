module V1
  module Connection
    class Accept < FirstTouch::Operation
      step Rescue(handler: :rollback!) {
        step Wrap ->((_ctx), *, &block) { ActiveRecord::Base.transaction do block.call end } {
          step :update_user_one_connection
          failure :error_updating_connection, fail_fast: true
          step :find_matching_connection
          failure :matching_connection_not_found, fail_fast: true
          step :update_user_two_connection
          failure :error_updating_connection, fail_fast: true
        }
      }

      def rollback!(exception, options)
        options[:errors] = exception.message
      end

      # NOTE: requested status means that the user has requested a connection
      # but it has not yet been accepted by the other user
      def update_user_one_connection(options, params:, current_user:, **)
        conn_params = {
          id: params[:id],
          status: 'accepted'
        }
        options[:user] = Update.(
          params: conn_params, current_user: current_user
        )
        options[:user].success?
      end

      def find_matching_connection(options, **)
        my_connection = options[:user][:model]
        options[:matching_conn] = ::Connection.find_by(
          user_id: my_connection.connected_to_id,
          connected_to_id: my_connection.user_id
        )
        !options[:matching_conn].nil?
      end

      def matching_connection_not_found(options, **)
        options[:errors] = 'Matching connection not found'
      end

      # NOTE: pending status means that the user has received a connection
      # request that is yet pending to be accepted
      def update_user_two_connection(options, current_user:, **)
        conn_params = {
          id: options[:matching_conn].id,
          status: 'accepted'
        }
        options[:friend] = Update.(
          params: conn_params, current_user: current_user
        )
        options[:friend].success?
      end

      def error_updating_connection(options, **)
        options['contract.default'] = if options[:user].failure?
                                        options[:user].errors
                                      else
                                        options[:friend].errors
                                      end
      end
    end
  end
end

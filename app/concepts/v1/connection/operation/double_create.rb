module V1
  module Connection
    class DoubleCreate < FirstTouch::Operation
      step Rescue(handler: :rollback!) {
        step Wrap ->((_ctx), *, &block) { ActiveRecord::Base.transaction do block.call end } {
          step :find_connecting_to
          failure :connecting_to_not_found, fail_fast: true
          step :create_user_one_connection
          failure :error_creating_connection, fail_fast: true
          step :create_user_two_connection
          failure :error_creating_connection, fail_fast: true
          step :notify_user
        }
      }

      def rollback!(exception, options)
        options[:errors] = exception.message
      end

      def find_connecting_to(options, params:, **)
        options[:connecting_to] = ::User.find_by(id: params['connected_to_id'])
        !options[:connecting_to].nil?
      end

      def connecting_to_not_found(options, params:, **)
        options[:errors] = I18n.t('models.not_found', model: 'User', id: params['connected_to_id'])
      end

      # NOTE: requested status means that the user has requested a connection
      # but it has not yet been accepted by the other user
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

      # NOTE: pending status means that the user has received a connection
      # request that is yet pending to be accepted
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

      def notify_user(options, params:, current_user:, **)
        NotificationCenter.send_notification(
          'connection-requested',
          {
            requestor_id: current_user.id,
            connection_id: options[:friend][:model].id
          },
          params[:connected_to_id]
        )
      end
    end
  end
end

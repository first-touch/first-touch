module V1
  module User
    class Show < FirstTouch::Operation
      step Model(::User, :find_by)
      step :setup_twin_model!
      step :build_response!

      def setup_twin_model!(options, current_user:, model:, **)
        following = options[:current_user].following?(model)
        user_connection = UsersConnection.new(current_user.id, model.id)
        connection_status = user_connection.status
        options['twin'] = ::V1::Twins::UserTwin.new(
          model,
          following: following,
          connection_status: connection_status
        )
      end

      def build_response!(options, twin:, **)
        options['response'] = Representer::PublicProfile.new(twin)
      end
    end
  end
end

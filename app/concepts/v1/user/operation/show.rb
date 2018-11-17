module V1
  module User
    class Show < FirstTouch::Operation
      step Model(::User, :find_by)
      step :setup_twin_model!
      step :build_response!

      def setup_twin_model!(options, **)
        following = options[:current_user].following?(model)
        connection_status = options[:current_user].connection_status(model)
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

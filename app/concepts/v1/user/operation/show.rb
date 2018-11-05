module V1
  module User
    class Show < FirstTouch::Operation
      step Model(::User, :find_by)
      failure :model_not_found!, fail_fast: true
      step :setup_twin_model!

      def setup_twin_model!(options, model:, current_user:, **)
        following = current_user.following?(model)
        connection_status = current_user.connection_status(model)
        options['model'] = ::V1::Twins::UserTwin.new(
          model,
          following: following,
          connection_status: connection_status
        )
      end
    end
  end
end

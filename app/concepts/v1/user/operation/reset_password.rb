module V1
  module User
    class ResetPassword < FirstTouch::NoAuthOperation
      step :find_user!
      step :send_reset_instructions!

      def find_user!(options, params:, **)
        user = ::User.find_by(email: params[:email])
        options['user'] = user
      end

      def send_reset_instructions!(user:, **)
        return true if user.nil?
        user.send_reset_password_instructions
      end
    end
  end
end

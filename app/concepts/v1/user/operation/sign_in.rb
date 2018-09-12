module V1
  module User
    class SignIn < FirstTouch::NoAuthOperation
      step :find_user!
      failure :unauthenticated!
      step :generate_token!

      def find_user!(options, params:, **)
        user = ::User.find_by(email: params[:email])
        return false unless user
        user.confirmed? && user.valid_password?(params[:password])
        options['user'] = user
      end

      def generate_token!(options, **)
        jwt = JsonWebToken.encode(
          { user_id: options['user'].id,
            last_logout: options['user'].last_logout_at.to_i },
          Time.now + FirstTouch::TOKEN_TTL
        )
        options['model'] = OpenStruct.new(auth_token: jwt)
      end
    end
  end
end

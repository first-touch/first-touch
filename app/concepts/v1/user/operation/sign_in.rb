module V1
  module User
    class SignIn < FirstTouch::NoAuthOperation
      step :find_user!
      failure :unauthenticated!, fail_fast: true
      step :confirmed_user?
      failure :unconfirmed!, fail_fast: true
      step :find_clubs!
      step :generate_token!

      def find_user!(options, params:, **)
        user = ::User.find_by(email: params[:email])
        return false unless user&.valid_password?(params[:password])
        options[:user] = user
      end

      def unauthenticated!(options, **)
        super
        options[:errors] = I18n.t('user.invalid_credentials')
      end

      def confirmed_user?(_opts, user:, **)
        user.confirmed?
      end

      def unconfirmed!(options, **)
        options[:errors] = I18n.t('user.unconfirmed_account')
      end

      def find_clubs!(options, **)
        options[:clubs] = []
        options[:user].managed_clubs.each do |club|
          options[:clubs].push(
            name: club.name,
            id: club.id,
            token: JsonWebToken.encode({ club_id: club.id },
                                       Time.now + FirstTouch::TOKEN_TTL)
          )
        end
      end

      def generate_token!(options, **)
        jwt = JsonWebToken.encode(
          { user_id: options[:user].id,
            last_logout: options[:user].last_logout_at.to_i },
          Time.now + FirstTouch::TOKEN_TTL
        )

        options[:model] = OpenStruct.new(
          auth_token: jwt, clubs_token: options[:clubs]
        )
      end
    end
  end
end

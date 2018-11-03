module V1
  module User
    class SignIn < FirstTouch::NoAuthOperation
      step :find_user!
      failure :unauthenticated!
      step :find_clubs!
      step :generate_token!

      def find_user!(options, params:, **)
        user = ::User.find_by(email: params[:email])
        return false unless user
        user.confirmed? && user.valid_password?(params[:password])
        options['user'] = user
      end

      def find_clubs!(options, **)
        options['clubs'] = []
        options['user'].clubs.each do |club|
          options['clubs'].push(
            name: club.name,
            id: club.id,
            token: JsonWebToken.encode({ club_id: club.id },
                                       Time.now + FirstTouch::TOKEN_TTL)
          )
        end
      end

      def generate_token!(options, **)
        jwt = JsonWebToken.encode(
          { user_id: options['user'].id,
            last_logout: options['user'].last_logout_at.to_i },
          Time.now + FirstTouch::TOKEN_TTL
        )
        puts options['clubs'].to_json

        options['model'] = OpenStruct.new(
          auth_token: jwt, clubs_token: options['clubs']
        )
      end
    end
  end
end

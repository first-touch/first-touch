module V1
  module Session
    class Validate < FirstTouch::NoAuthOperation
      step Policy::Guard(:decode_token!, name: :decode)
      failure :missing_auth_token, fail_fast: true
      step :find_user!

      def decode_token!(options, params:, **)
        http_headers = ActionDispatch::Http::Headers.from_hash(params[:headers])
        return false if http_headers['Authorization'].blank?
        token = http_headers['Authorization'].split(' ').last
        options['decoded_token'] = JsonWebToken.decode(token)
      end

      def missing_auth_token(options)
        options['errors'] = 'missing token'
      end

      def find_user!(options, decoded_token:, **)
        user_conditions = { id: decoded_token[:user_id] }

        if decoded_token[:last_logout] != 0
          last_logout = Time.at(decoded_token[:last_logout]).to_datetime
          min_date = last_logout - 1.second
          max_date = last_logout + 1.second
          user_conditions[:last_logout_at] = [min_date..max_date]
        end
        options['user'] = ::User.find_by(user_conditions)
      end
    end
  end
end

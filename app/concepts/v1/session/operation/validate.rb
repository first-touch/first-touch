module V1
  module Session
    class Validate < FirstTouch::NoAuthOperation
      step Policy::Guard(:decode_token!, name: :decode)
      failure :missing_auth_token, fail_fast: true
      step :find_user!
      step :find_club!

      def decode_token!(options, params:, **)
        http_headers = ActionDispatch::Http::Headers.from_hash(params[:headers])
        return false if http_headers['Authorization'].blank?
        token = http_headers['Authorization'].split(' ').last
        options[:decoded_token] = JsonWebToken.decode(token)
        return false unless options[:decoded_token]
        options[:decoded_club_token] = nil
        return true if http_headers['ClubAuthorization'].blank?
        begin
          token_club = http_headers['ClubAuthorization'].split(' ').last
          options[:decoded_club_token] = JsonWebToken.decode(token_club)
        rescue StandardError => e
          options[:decoded_club_token] = nil
        end
        true
      end

      def missing_auth_token(options, **)
        options[:errors] = 'missing token'
      end

      def find_user!(options, decoded_token:, **)
        user_conditions = { id: decoded_token[:user_id] }

        if decoded_token[:last_logout] != 0
          last_logout = Time.at(decoded_token[:last_logout]).to_datetime
          min_date = last_logout - 1.second
          max_date = last_logout + 1.second
          user_conditions[:last_logout_at] = [min_date..max_date]
        end
        options[:user] = ::User.find_by(user_conditions)
      end

      def find_club!(options, decoded_club_token:, **)
        return true if decoded_club_token.blank? || decoded_club_token[:club_id].blank?
        options[:club] = ::Club.find_by id: decoded_club_token[:club_id]
      end
    end
  end
end

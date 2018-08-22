module V1
  module User
    class ClubToken < FirstTouch::Operation
      step :look_for_club!
      failure :club_not_found!, fail_fast: true
      step :generate_club_token!

      def look_for_club!(options, current_user:, **)
        # FIXME: Theoretically a user can own more than one club.
        # For simplicity we assume there aren't scenarios like that for now
        options['club'] = current_user.clubs.first
        !options['club'].nil?
      end

      def club_not_found!(options)
        options['result.model'] = I18n.t 'not_club_owner'
      end

      def generate_club_token!(options, current_user:, club:, **)
        token_params = {
          account_owner_id: current_user.id,
          account_owner_last_logout: current_user.last_logout_at,
          club_id: club.id
        }
        token = JsonWebToken.encode(token_params, 1.week.from_now)
        options['model'] = { club_token: token }
      end
    end
  end
end

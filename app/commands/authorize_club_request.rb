class AuthorizeClubRequest < TokenBased
  prepend SimpleCommand

  def call
    club
  end

  private

  def club
    return @result if @result
    if decoded_club_auth_token
      user_conditions = {
        id: decoded_club_auth_token[:account_owner_id],
      }
      club_id = decoded_club_auth_token[:club_id]

      if decoded_club_auth_token[:last_logout] != 0
        last_logout = Time.at(decoded_club_auth_token[:last_logout]).to_datetime
        min_date = last_logout - 1.second
        max_date = last_logout + 1.second
        user_conditions[:last_logout_at] = [min_date..max_date]
      else
        user_conditions[:last_logout_at] = nil
      end
      @user ||= User.find_by(user_conditions)
      @club ||= Club.find_by id: club_id
    end
    @result = { user: @user, club: @club }
  end
end

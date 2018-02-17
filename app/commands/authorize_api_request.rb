class AuthorizeApiRequest < TokenBased
  prepend SimpleCommand

  def call
    user
  end

  private

  def user
    if decoded_auth_token
      user_conditions = { id: decoded_auth_token[:user_id],
                          password_digest: decoded_auth_token[:digest] }

      if decoded_auth_token[:last_logout] != 0
        last_logout = Time.at(decoded_auth_token[:last_logout]).to_datetime
        min_date = last_logout - 1.second
        max_date = last_logout + 1.second
        user_conditions[:last_logout_at] = [min_date..max_date]
      else
        user_conditions[:last_logout_at] = nil
      end

      @user ||= User.find_by(user_conditions)
    end
    @user || errors.add(:token, 'Invalid token') && nil
  end
end

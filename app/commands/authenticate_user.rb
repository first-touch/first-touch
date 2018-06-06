class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return nil unless user
    clubs = []

    user.clubs.each do |club|
      clubs.push(
        {
          name: club.name,
          id: club.id,
          token: JsonWebToken.encode({ account_owner_id: user.id,
            account_owner_digest: user.password_digest,
            club_id: club.id,
            last_logout: user.last_logout_at.to_i },
          1.week.from_now)
        }
      )
    end
    {
      user: JsonWebToken.encode({ user_id: user.id,
        digest: user.password_digest,
        last_logout: user.last_logout_at.to_i },
      1.week.from_now),
      clubs: clubs
    }

  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    errors.add :user_authentication, 'invalid credentials'
    nil
  end
end

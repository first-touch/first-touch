class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return nil unless user
    JsonWebToken.encode({ user_id: user.id,
                          digest: user.password_digest,
                          last_logout: user.last_logout_at.to_i },
                        1.week.from_now)
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

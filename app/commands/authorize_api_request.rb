require './lib/json_web_token'

class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers={})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    if decoded_auth_token
      last_logout = Time.at(decoded_auth_token[:last_logout]).to_datetime
      min_date = last_logout - 1.second
      max_date = last_logout + 1.second
      @user ||= User.find_by(id: decoded_auth_token[:user_id],
                             password_digest: decoded_auth_token[:digest],
                             last_logout_at: [min_date..max_date]
                            )
    end
    @user || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    headers = ActionDispatch::Http::Headers.from_hash(@headers)
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end

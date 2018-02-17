require './lib/json_web_token'

class TokenBased
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    puts 'Not implemented'
  end

  private

  attr_reader :headers

  def decoded_club_auth_token
    @decoded_club_auth_token ||= JsonWebToken.decode(
      http_auth_header('ClubAuthorization')
    )
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(
      http_auth_header('Authorization')
    )
  end

  def http_auth_header(header)
    headers = ActionDispatch::Http::Headers.from_hash(@headers)
    if headers[header].present?
      return headers[header].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end

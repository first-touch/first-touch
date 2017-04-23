require './lib/json_web_token'

class TokenBased
  prepend SimpleCommand

  def initialize(headers={})
    @headers = headers
  end

  def call
    puts "Not implemented"
  end

  private

  attr_reader :headers

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

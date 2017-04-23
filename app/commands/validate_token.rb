class ValidateToken < TokenBased
  prepend SimpleCommand

  def call
    token
  end

  private

  def token
    if decoded_auth_token
      expiry_timestamp = decoded_auth_token[:exp].to_i
      return Time.now.to_i > expiry_timestamp
    end
    errors.add(:token, 'Invalid token') && nil
  end
end

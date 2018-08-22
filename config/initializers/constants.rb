module FirstTouch
  REGISTERABLE_ROLE_NAMES = %w[player scout manager coach director].freeze
  REDIS_NOTES_SUBSCRIBE_CHANNEL = 'yustynn-channel'.freeze
  REDIS_NOTES_PUBLISH_CHANNEL = 'yustynn-channel-channel'.freeze

  TOKEN_TTL = 1.week
end

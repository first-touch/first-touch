module FirstTouch
  REGISTERABLE_ROLE_NAMES = %w[player scout agent director].freeze
  REDIS_NOTES_SUBSCRIBE_CHANNEL = 'yustynn-channel'.freeze
  REDIS_NOTES_PUBLISH_CHANNEL = 'yustynn-channel-channel'.freeze

  TOKEN_TTL = 1.week
  REGISTERABLE_REPORT_TYPES = %w[Player Team].freeze
  REGISTERABLE_REPORT_STATUS = %w[draft publish pending private deleted].freeze
  REGISTERABLE_REQUEST_TYPES = %w[Player Team Position].freeze
  REGISTERABLE_REQUEST_STATUS = %w[draft publish private deleted].freeze

  REGISTERABLE_ORDER_STATUS = %w[completed pending_report refused refounded canceled].freeze
  AVATAR = 'https://cdn4.iconfinder.com/data/icons/green-shopper/1068/user.png'
  CLUB_LOGO = 'https://s3-us-west-1.amazonaws.com/first-touch-web/assets/FT_Icons_Club_220217.png'
end

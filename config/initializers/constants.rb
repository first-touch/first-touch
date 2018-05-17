module FirstTouch
  REGISTERABLE_ROLE_NAMES = %w[player scout manager coach director].freeze
  REGISTERABLE_REPORT_TYPES = %w[player team].freeze
  REGISTERABLE_REPORT_STATUS = %w[draft publish private deleted].freeze
  REGISTERABLE_REQUEST_TYPES = %w[player team position].freeze
  REGISTERABLE_REQUEST_STATUS = %w[draft publish private deleted].freeze

  REGISTERABLE_ORDER_STATUS = %w[completed pending_report refused refounded].freeze
end

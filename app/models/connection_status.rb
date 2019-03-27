class ConnectionStatus
  STATUSES = %w[requested pending accepted rejected blocked].freeze

  def initialize(status)
    @status = status
  end
end

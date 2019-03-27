class UsersConnection
  def initialize(user_id, connected_to_id)
    @connection = ::Connection.find_by(
      user_id: user_id, connected_to_id: connected_to_id
    )
  end

  def status
    return 'none' unless @connection

    @connection.status.to_s
  end
end

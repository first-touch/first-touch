class Connection < ApplicationRecord
  enum status: array_to_enum_hash(ConnectionStatus::STATUSES), _prefix: true

  belongs_to :user, class_name: 'User'
  belongs_to :connected_to, class_name: 'User'

  def status
    @status ||= ConnectionStatus.new(read_attribute(:status))
  end
end

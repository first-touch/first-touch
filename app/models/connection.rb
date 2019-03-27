class Connection < ApplicationRecord
  enum status: {
    requested: 'requested',
    pending: 'pending',
    accepted: 'accepted',
    rejected: 'rejected',
    blocked: 'blocked'
  }

  belongs_to :user, class_name: 'User'
  belongs_to :connected_to, class_name: 'User'
end

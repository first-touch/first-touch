class Connection < ApplicationRecord
  PENDING = 'pending'
  ACCEPTED = 'accepted'
  REJECTED = 'rejected'

  STATUS = [PENDING, ACCEPTED, REJECTED].freeze
end

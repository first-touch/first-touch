class Connection < ApplicationRecord
  PENDING = 'pending'.freeze
  ACCEPTED = 'accepted'.freeze
  REJECTED = 'rejected'.freeze

  STATUS = [PENDING, ACCEPTED, REJECTED].freeze

  belongs_to :user, class_name: 'User'
  belongs_to :connected_to, class_name: 'User'
end

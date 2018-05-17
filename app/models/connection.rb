class Connection < ApplicationRecord
  PENDING = 'pending'.freeze
  ACCEPTED = 'accepted'.freeze
  REJECTED = 'rejected'.freeze

  STATUS = [PENDING, ACCEPTED, REJECTED].freeze
end

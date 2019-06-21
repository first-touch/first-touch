class RequestBid < ApplicationRecord
  # TODO: Add unique validation scoped to user and request
  # A user can only have one request bid for each request
  belongs_to :user
  belongs_to :request

  has_one :order
  has_many :attachments

  # TODO: Migrate this to a DB enum
  scope :accepted, -> { where(status: 'accepted') }
end

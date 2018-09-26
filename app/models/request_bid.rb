class RequestBid < ApplicationRecord
  belongs_to :user
  belongs_to :request

  has_one :order
  has_many :attachments
end

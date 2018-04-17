class Request < ApplicationRecord
  belongs_to :user
  has_many :request_bids

  validates :status, inclusion: {
    in: FirstTouch::REGISTERABLE_REQUEST_STATUS
  }
end

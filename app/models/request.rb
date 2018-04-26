class Request < ApplicationRecord
  belongs_to :user
  has_many :request_bids
  belongs_to :player, class_name: 'User'
  belongs_to :team, optional: true

  validates :status, inclusion: {
    in: FirstTouch::REGISTERABLE_REQUEST_STATUS
  }
end

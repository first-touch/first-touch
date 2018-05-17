class Request < ApplicationRecord
  belongs_to :user
  has_many :request_bids
  belongs_to :player, class_name: 'User'
  belongs_to :team, optional: true
  belongs_to :league, optional: true, class_name: 'Competition'

  validates :status, inclusion: {
    in: FirstTouch::REGISTERABLE_REQUEST_STATUS
  }

  scope :published, -> { where(status: 'publish') }
end

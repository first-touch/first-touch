class Request < ApplicationRecord
  belongs_to :user

  validates :status, inclusion: {
    in: FirstTouch::REGISTERABLE_REQUEST_STATUS
  }
end

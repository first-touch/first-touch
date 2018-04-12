class Order < ApplicationRecord
  belongs_to :user
  belongs_to :report
  belongs_to :club, class_name: 'User', foreign_key: :customer_id

  validates :status, inclusion: {
    in: FirstTouch::REGISTERABLE_ORDER_STATUS
  }
end

class Order < ApplicationRecord
  belongs_to :user
  belongs_to :report
  belongs_to :club, class_name: 'User', foreign_key: :customer_id

  has_many :stripe_transactions
  validates :status, inclusion: {
    in: FirstTouch::REGISTERABLE_ORDER_STATUS
  }
end

class Report < ApplicationRecord
  belongs_to :user
  belongs_to :club, optional: true
  belongs_to :player, class_name: 'User'
  has_many :attachments

  has_many :orders

  # validates :price, numericality: {
  #   only_integer: true,
  #   greater_than_or_equal_to: 0,
  #   less_than_or_equal_to: 999_999
  # }

  validates :type_report, inclusion: {
    in: FirstTouch::REGISTERABLE_REPORT_TYPES
  }
  validates :status, inclusion: {
    in: FirstTouch::REGISTERABLE_REPORT_STATUS
  }

  validates_presence_of :headline, :type_report, :price
end

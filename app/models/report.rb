class Report < ApplicationRecord
  belongs_to :user
  belongs_to :club, optional: true

  validates :price, numericality: {
    only_integer: true,
    greater_than: 0,
    less_than_or_equal_to: 999999
  }

  validates_presence_of :headline, :type_report, :price
end

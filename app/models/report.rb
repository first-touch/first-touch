class Report < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :club, optional: true
  belongs_to :player, class_name: 'User'
  belongs_to :team, optional: true
  belongs_to :league, optional: true, class_name: 'Competition'

  has_many :attachments
  has_one :request_bid
  has_one :request, through: :request_bid
  has_many :orders

  scope :not_hided, -> { where.not(status: ['pending', 'deleted']) }

  def self.purchased_by_user_or_publish(user_id)
    joins = "LEFT JOIN orders ON orders.customer_id = #{user_id}"\
    ' AND orders.report_id = reports.id'
    where('reports.status = ? OR orders.status = ?', 'publish', 'completed')
    .joins(joins)
   .select('reports.*, orders.status AS orders_status')
  end

  def self.joins_orders

  end

  def self.proposed_reports(request_id)
    where('reports.request_id = ?', request_id)
  end

  def self.purchased_by_user(user_id)
    joins(orders: :user)
      .where(orders: { status: ['completed', 'pending_report'], customer_id: user_id })
      .select(
        'reports.*, orders.status AS orders_status,'\
        ' orders.price AS orders_price'
      )
  end

  # TODO: Validation will be reworked
  # validates :price, numericality: {
  #   only_integer: true,
  #   greater_than_or_equal_to: 0,
  #   less_than_or_equal_to: 999_999
  # }

  # validates :type_report, inclusion: {
  #   in: FirstTouch::REGISTERABLE_REPORT_TYPES
  # }
  # validates :status, inclusion: {
  #   in: FirstTouch::REGISTERABLE_REPORT_STATUS
  # }

  # validates_presence_of :headline, :type_report, :price
end

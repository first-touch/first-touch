class Club < ApplicationRecord
  belongs_to :account_owner, class_name: 'User'
  has_many :club_users
  has_many :users, through: :club_users
  has_many :requests
  has_many :organizing_events, foreign_key: :organizer_id, class_name: 'Event'
  has_many :participating_events, foreign_key: :opponent_id, class_name: 'Event'
  has_many :reports_buy, foreign_key: :customer_id, class_name: 'Order'
  has_many :posts, as: :author, foreign_key: 'author_id'
  has_many :teams
  has_one_attached :club_logo

  validates_presence_of :name, :country_code

  def events
    Event.in_future.where(organizer_id: id)
         .or(Event.in_future.where(opponent_id: id))
  end

  def feed
    posts.order('updated_at DESC')
  end

  def display_name
    [name, city, country_code].join ' - '
  end
end

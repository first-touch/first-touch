class Club < ApplicationRecord
  belongs_to :account_owner, class_name: 'User'
  has_many :club_users
  has_many :users, through: :club_users

  has_many :teams

  validates_presence_of :name, :city, :country_code
end

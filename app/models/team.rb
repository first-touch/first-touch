class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users
  belongs_to :club

  validates_presence_of :team_name
end

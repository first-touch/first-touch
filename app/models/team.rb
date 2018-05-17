class Team < ApplicationRecord
  has_many :team_users
  has_many :users, through: :team_users
  has_many :team_competitions
  has_many :competition_season, through: :team_competitions
  has_many :competitions, through: :competition_season

  belongs_to :club

  validates_presence_of :team_name
end

class ClubUser < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates_presence_of :club, :user
end

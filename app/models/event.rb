class Event < ApplicationRecord
  belongs_to :organizer, class_name: 'Club', foreign_key: :organizer_id
  belongs_to :opponent, class_name: 'Club', foreign_key: :opponent_id

  EVT_TYPES = {
    league_match: 0,
    cup_match: 1,
    friendly_match: 2,
    trainning: 3,
    social: 4
  }.freeze

  enum evt_type: EVT_TYPES

  scope :in_future, -> { where('start_date >= ?', DateTime.now) }
end

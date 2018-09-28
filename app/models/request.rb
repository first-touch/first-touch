class Request < ApplicationRecord
  belongs_to :club
  has_many :request_bids
  belongs_to :player, class_name: 'User'
  belongs_to :team, optional: true
  belongs_to :league, optional: true, class_name: 'Competition'
  PLAYER_SCHEMA = "#{Rails.root}/app/models/schemas/request/player_data.json".freeze
  TEAM_SCHEMA = "#{Rails.root}/app/models/schemas/request/team_data.json".freeze
  POSITION_SCHEMA = "#{Rails.root}/app/models/schemas/request/position_data.json".freeze

  validates :meta_data, presence: true, json: { schema: PLAYER_SCHEMA }, if: :is_player_request
  validates :meta_data, presence: true, json: { schema: TEAM_SCHEMA }, if: :is_team_request
  validates :meta_data, presence: true, json: { schema: POSITION_SCHEMA }, if: :is_position_request

  scope :not_hided, -> { where.not(status: %w[pending deleted]) }

  def is_player_request
    type_request == 'player'
  end

  def is_team_request
    type_request == 'team'
  end

  def is_position_request
    type_request == 'position'
  end

  scope :published, -> { where(status: 'publish') }
end

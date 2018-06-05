class Request < ApplicationRecord
  belongs_to :user
  has_many :request_bids
  belongs_to :player, class_name: 'User'
  belongs_to :team, optional: true
  belongs_to :league, optional: true, class_name: 'Competition'
  PLAYER_SCHEMA = "#{Rails.root}/app/models/schemas/request/player_data.json"
  TEAM_SCHEMA = "#{Rails.root}/app/models/schemas/request/team_data.json"
  POSITION_SCHEMA = "#{Rails.root}/app/models/schemas/request/position_data.json"

  validates :meta_data, presence: true, json: { schema: PLAYER_SCHEMA }, if: :is_player_request
  validates :meta_data, presence: true, json: { schema: TEAM_SCHEMA }, if: :is_team_request
  validates :meta_data, presence: true, json: { schema: POSITION_SCHEMA }, if: :is_position_request

  scope :not_hided, -> { where.not(status: ['pending', 'deleted']) }

  def is_player_request
      self.type_request == 'player'
  end

  def is_team_request
    self.type_request == 'team'
  end

  def is_position_request
    self.type_request == 'position'
  end

  # validates :status, inclusion: {
  #   in: FirstTouch::REGISTERABLE_REQUEST_STATUS
  # }

  scope :published, -> { where(status: 'publish') }
end

class Request < ApplicationRecord
  belongs_to :user

  belongs_to :club, optional: true
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

  # TODO: Make status an enum
  # Possible status are:
  # - Draft - User created, saved it but not published yet
  #   - Actions avail in UI should be publish and edit
  # - Published - User created and published
  #   - Actions avail in UI should be close and edit
  # - Closed - User closed it
  #   - Actions avail in UI should be re-open (takes the user to the edit form)
  # - Expired - Date of submission has passed
  #   - Actions avail in UI should be re-open (takes the user to the edit form)
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

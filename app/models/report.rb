# TODO: Remove request_id from the schema as it does not make sense
# TODO: Make report type enum:
#  - player
#  - team
# TODO: Make report status enum:
#  - published
#  - ongoing
#  - private (unpublished)

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
  PLAYER_SCHEMA = "#{Rails.root}/app/models/schemas/report/player_data.json".freeze
  TEAM_SCHEMA = "#{Rails.root}/app/models/schemas/report/team_data.json".freeze
  validates :meta_data, presence: true, json: { schema: PLAYER_SCHEMA }, if: :is_player_report
  validates :meta_data, presence: true, json: { schema: TEAM_SCHEMA }, if: :is_team_report

  scope :not_hided, -> { where.not(status: %w[pending deleted], completion_status: 'pending') }

  def is_player_report
    type_report == 'player'
  end

  def is_team_report
    type_report == 'team'
  end

  def self.purchased_by_club_or_publish(club_id)
    joins = "LEFT JOIN orders ON orders.customer_id = #{club_id}"\
    ' AND orders.report_id = reports.id'
    where('reports.status = ? OR orders.status = ?', 'publish', 'completed')
      .joins(joins)
      .select('reports.*, orders.status AS orders_status')
  end

  def player_info
    if type_report == 'player'
      if !player_id
        meta_data['player_info']
      else
        player.personal_profile
      end
    end
  end

  def player_name
    if type_report == 'player'
      if !player_id
        meta_data['search']['player']
      else
        player.search_string
      end
    end
  end

  def player_field(field)
    if type_report == 'player'
      r = player_info[field]
      return [r] if (field == 'playing_position') && player_id
      return r.nil? ? 0 : r
    end
    nil
  end

  def club_name
    if type_report == 'team'
      if !team_id
        meta_data['search']['team']
      else
        team.team_name
      end
    end
  end

  def league_name
    if type_report == 'team'
      if !team_id
        [meta_data['search']['league']]
      else
        team.competitions.map(&:name)
      end
    end
  end

  def category
    if type_report == 'team'
      meta_data['category'] ? meta_data['category'] : ''
    end
  end

  def self.proposed_reports(request_id)
    where('reports.request_id = ?', request_id)
  end

  def self.purchased_by_club(club_id)
    joins(orders: :user)
      .where(orders: { status: %w[completed pending_report], customer_id: club_id })
      .select(
        'reports.*, orders.status AS orders_status,'\
        ' orders.price AS orders_price'
      )
  end

  class ReportOfRequestValidator < ActiveModel::Validator
    def validate(record)
      unless status_is_compatible record
        record.errors.add :base, 'This record is invalid'
      end
    end

    private

    def status_is_compatible(record)
      if !record.field_read('request_id').nil? && (record.status != 'private')
        return false
        end
      true
      end
  end
end

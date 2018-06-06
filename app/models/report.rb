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
  # PLAYER_SCHEMA = "#{Rails.root}/app/models/schemas/report/player_data.json"
  # TEAM_SCHEMA = "#{Rails.root}/app/models/schemas/report/team_data.json"
  # validates :meta_data, presence: true, json: { schema: PLAYER_SCHEMA }, if: :is_player_report
  # validates :meta_data, presence: true, json: { schema: TEAM_SCHEMA }, if: :is_team_report

  scope :not_hided, -> { where.not(status: ['pending', 'deleted']) }

  def is_player_report
      self.type_report == 'player'
  end

  def is_team_report
    self.type_report == 'team'
  end


  def self.purchased_by_club_or_publish(club_id)
    joins = "LEFT JOIN orders ON orders.customer_id = #{club_id}"\
    ' AND orders.report_id = reports.id'
    where('reports.status = ? OR orders.status = ?', 'publish', 'completed')
    .joins(joins)
   .select('reports.*, orders.status AS orders_status')
  end

  def player_info
    if self.type_report == 'player'
      if !self.player_id
        return self.meta_data['player_info']
      else
        return self.player.personal_profile
      end
    end
  end

  def player_name
    if self.type_report == 'player'
      if !self.player_id
        return self.meta_data['search']['player']
      else
        return self.player.search_string
      end
    end
  end

  def player_field(field)
    if self.type_report == 'player'
      r = self.player_info[field]
      if field == 'playing_position' and self.player_id
          return [r]
      end
      return  r
    end
    nil
  end

  def club_name
    if self.type_report == 'team'
      if !self.team_id
        return self.meta_data['search']['team']
      else
        return self.team.team_name
      end
    end
  end

  def league_name
    if self.type_report == 'team'
      if !self.team_id
        return [self.meta_data['search']['league']]
      else
        return self.team.competitions.map(&:name)
      end
    end
  end
  def category
    if self.type_report == 'team'
      self.meta_data['category'] ? self.meta_data['category'] : ''
    end
  end

  def self.proposed_reports(request_id)
    where('reports.request_id = ?', request_id)
  end

  def self.purchased_by_club(club_id)
    joins(orders: :user)
      .where(orders: { status: ['completed', 'pending_report'], customer_id: club_id })
      .select(
        'reports.*, orders.status AS orders_status,'\
        ' orders.price AS orders_price'
      )
  end

  class ReportValidator < ActiveModel::Validator
    def validate(record)
      if !status_is_compatible record
        record.errors.add :base, 'This record is invalid'
      end
    end

    private
    def status_is_compatible(record)
      if !record.field_read('request_id').nil? and record.status != 'private'
          return false
        end
        return true
      end
  end
end

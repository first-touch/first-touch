class TeamCompetition < ApplicationRecord
  # TODO: Migrate the table to rails defaults
  self.table_name = 'teams_competitions'

  belongs_to :team
  belongs_to :competition_season
end

class CreateTeamCompetition < ActiveRecord::Migration[5.1]
  def change
    create_table :teams_competitions do |t|
      t.references :team, foreign_key: true
      t.references :competition_season, foreign_key: true
      t.timestamps
    end
  end
end

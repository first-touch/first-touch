class CreateCompetitionSeason < ActiveRecord::Migration[5.1]
  def change
    create_table :competition_seasons do |t|
      t.date :start_date
      t.date :end_date
      t.references :competition, foreign_key: true
      t.timestamps
    end
  end
end

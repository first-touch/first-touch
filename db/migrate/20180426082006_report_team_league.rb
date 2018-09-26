class ReportTeamLeague < ActiveRecord::Migration[5.1]
  def change
    rename_column :reports, :club_id, :team_id
    add_column :reports, :league_id, :integer
  end
end

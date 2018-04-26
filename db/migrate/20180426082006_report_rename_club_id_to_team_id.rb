class ReportRenameClubIdToTeamId < ActiveRecord::Migration[5.1]
  def change
    rename_column :reports, :club_id, :team_id
  end
end

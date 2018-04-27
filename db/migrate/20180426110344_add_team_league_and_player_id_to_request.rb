class AddTeamLeagueAndPlayerIdToRequest < ActiveRecord::Migration[5.1]
  def change
    add_column :requests, :player_id, :integer
    add_column :requests, :team_id, :integer
    add_column :requests, :league_id, :integer
  end
end

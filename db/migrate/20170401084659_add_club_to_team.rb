class AddClubToTeam < ActiveRecord::Migration[5.0]
  def change
    add_column :teams, :club_id, :integer
    add_index :teams, :club_id
  end
end

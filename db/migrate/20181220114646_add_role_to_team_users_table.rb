class AddRoleToTeamUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :team_users, :role, :string
  end
end

class UpdatePlayerPositionsToBeArray < ActiveRecord::Migration[5.1]
  def change
    remove_column :personal_profiles, :playing_position
    add_column :personal_profiles, :playing_positions, :jsonb
  end
end

class AddPlayerProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :personal_profiles, :playing_position, :string
    add_column :personal_profiles, :pro_status, :string
    add_column :personal_profiles, :total_caps, :integer
  end
end

class AddLastLogoutAtToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_logout_at, :timestamp
  end
end

class CreateClubUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :club_users do |t|
      t.references :club, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

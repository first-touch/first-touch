class RefactorAfterClubToken < ActiveRecord::Migration[5.1]
  def change
    remove_column :requests, :user_id
    add_reference :requests, :club, foreign_key: true
    add_column :clubs, :stripe_id, :text
  end
end

class CreateStripeFts < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_fts do |t|
      t.text :preferred_account
      t.text :stripe_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

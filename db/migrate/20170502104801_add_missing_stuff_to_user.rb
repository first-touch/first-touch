class AddMissingStuffToUser < ActiveRecord::Migration[5.1]
  def change
    add_reference :career_entries, :club, foreign_key: true

    create_table :awards do |t|
      t.references :user, index: true, foreign_key: true
      t.references :club, index: true, foreign_key: true
      t.string :title
      t.datetime :season

      t.timestamps null: false
    end

    add_column :personal_profiles, :languages, :string, array: true
  end
end

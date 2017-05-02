class CreateCareerEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :career_entries do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end

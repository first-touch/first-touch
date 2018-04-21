class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.text :headline
      t.string :status
      t.string :type_report
      t.references :user, foreign_key: true
      t.integer :price
      t.references :club, foreign_key: true
      t.integer :player_id

      t.timestamps
    end
  end
end

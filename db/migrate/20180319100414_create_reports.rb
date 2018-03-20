class CreateReports < ActiveRecord::Migration[5.1]
  def change
    create_table :reports do |t|
      t.text :headline
      t.boolean :index
      t.string :type_report
      t.integer :version
      t.references :user, foreign_key: true
      t.integer :price
      t.references :club, foreign_key: true
      t.integer :player

      t.timestamps
    end
  end
end

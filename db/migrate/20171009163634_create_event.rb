class CreateEvent < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :evt_type
      t.integer :organizer_id
      t.integer :opponent_id
      t.string :name
      t.string :venue
      t.datetime :start_date
      t.datetime :end_date
      t.text :description

      t.timestamps
    end

    add_index :events, :opponent_id
    add_index :events, :organizer_id
  end
end

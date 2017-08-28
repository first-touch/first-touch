class CreateConnections < ActiveRecord::Migration[5.1]
  def change
    create_table :connections do |t|
      t.integer :user_id
      t.integer :connected_to_id
      t.string :status

      t.timestamps null: false
    end

    add_index :connections, :user_id
    add_index :connections, :connected_to_id
    add_index :connections, [:user_id, :connected_to_id], unique: true
  end
end

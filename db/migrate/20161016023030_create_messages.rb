class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :subject
      t.text :message_body, null: false
      t.integer :creator_id, null: false
      t.timestamps null: false
    end
  end
end

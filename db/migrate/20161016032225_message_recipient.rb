class MessageRecipient < ActiveRecord::Migration[4.2]
  def change
    create_table :message_recipients do |t|
      t.integer :recipient_id, null: false
      t.integer :message_id, null: false
      t.datetime :read_at, null: true
    end
  end
end

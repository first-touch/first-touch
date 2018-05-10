class CreateStripeTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :stripe_transactions do |t|
      t.text :stripe_id
      t.boolean :refounded
      t.date :refound_at
      t.references :order, foreign_key: true
      t.text :type_transaction
      t.boolean :payout

      t.timestamps
    end
  end
end

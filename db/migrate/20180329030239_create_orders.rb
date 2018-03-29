class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.integer :customer_id
      t.integer :price
      t.references :report, foreign_key: true
      t.text :status

      t.timestamps
    end
  end
end

class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.text :type_request
      t.integer :min_price
      t.integer :max_price
      t.references :user, foreign_key: true
      t.date :deadline
      t.text :status
      t.json :meta_data

      t.timestamps
    end
  end
end

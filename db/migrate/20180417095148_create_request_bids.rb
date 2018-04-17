class CreateRequestBids < ActiveRecord::Migration[5.1]
  def change
    create_table :request_bids do |t|
      t.json :price
      t.references :user, foreign_key: true
      t.text :status
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end

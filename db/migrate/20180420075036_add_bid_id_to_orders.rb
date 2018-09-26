class AddBidIdToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :request_bid, foreign_key: true
  end
end

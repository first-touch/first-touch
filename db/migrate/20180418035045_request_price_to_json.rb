class RequestPriceToJson < ActiveRecord::Migration[5.1]
  def change
    remove_column :requests, :min_price
    remove_column :requests, :max_price
    add_column :requests, :price, :json
  end
end

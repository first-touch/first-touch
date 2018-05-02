class AddCancelationReasonToRequestBid < ActiveRecord::Migration[5.1]
  def change
    add_column :request_bids, :reason, :text
  end
end

class AddRequestBidToAttachment < ActiveRecord::Migration[5.1]
  def change
    add_reference :attachments, :request_bid, foreign_key: true
  end
end

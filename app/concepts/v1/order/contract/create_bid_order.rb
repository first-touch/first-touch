module V1
  module Order
    module Contract
      class CreateBidOrder < Reform::Form
        property :price
        property :status
        property :user
        property :report
        property :customer_id
        property :request_bid_id

        validates :price,
                  :status,
                  :user,
                  :customer_id,
                  presence: true
      end
    end
  end
end

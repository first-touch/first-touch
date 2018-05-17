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
        # validates_uniqueness_of :customer_id, scope: %i[report customer_id]
        # TODO: validates uniqueness of customer_id bid_id
      end
    end
  end
end

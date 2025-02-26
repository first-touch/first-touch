module V1
  module Order
    module Contract
      class Create < Reform::Form
        property :price
        property :status
        property :user
        property :report
        property :customer_id

        validates :price,
                  :status,
                  :user,
                  :report,
                  :customer_id,
                  presence: true
        validates_uniqueness_of :customer_id, scope: %i[report customer_id]
      end
    end
  end
end

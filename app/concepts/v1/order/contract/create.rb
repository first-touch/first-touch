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
      end
    end
  end
end
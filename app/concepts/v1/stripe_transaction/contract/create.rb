module V1
  module StripeTransaction
    module Contract
      class Create < Reform::Form
        property :order
        property :type_transaction
        property :stripe_id
        property :payout

        validates :order,
                  :type_transaction,
                  :stripe_id,
                  presence: true
      end
    end
  end
end

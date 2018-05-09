module V1
  module Stripe
    module Representer
      class FieldNeeded < Representable::Decorator
        include Representable::JSON

        property :verification_fields
        property :supported_bank_account_currencies
        property :id
      end
    end
  end
end

module V1
  module Stripe
    module Representer
      class FieldNeeded < Representable::Decorator
        include Representable::JSON

        property :verification_fields

      end
    end
  end
end

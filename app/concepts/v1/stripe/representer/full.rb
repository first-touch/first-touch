module V1
  module Stripe
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :legal_entity
        property :country
        property :default_currency
      end
    end
  end
end

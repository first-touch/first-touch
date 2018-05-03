module V1
  module Stripe
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :legal_entity

      end
    end
  end
end

module V1
  module Order
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :orders, decorator: Show

      end
    end
  end
end
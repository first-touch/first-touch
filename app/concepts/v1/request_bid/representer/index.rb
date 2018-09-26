module V1
  module RequestBid
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :bid, decorator: Full
      end
    end
  end
end

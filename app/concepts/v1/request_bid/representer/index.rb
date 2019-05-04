module V1
  module RequestBid
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :request_bids, decorator: Full
      end
    end
  end
end

module V1
  module Event
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :events, decorator: Full
      end
    end
  end
end

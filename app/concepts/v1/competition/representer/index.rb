module V1
  module Competition
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :competitions, decorator: Simplified
      end
    end
  end
end

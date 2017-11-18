module V1
  module Note
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :notes, decorator: Full
      end
    end
  end
end

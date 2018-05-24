module V1
  module Note
    module Representer
      class Tags < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: 'tags'
      end
    end
  end
end

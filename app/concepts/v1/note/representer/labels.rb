module V1
  module Note
    module Representer
      class Labels < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: 'labels'
      end
    end
  end
end

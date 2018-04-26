module V1
  module Competition
    module Representer
      class Simplified < Representable::Decorator
        include Representable::JSON

        property :name
        property :nation

      end
    end
  end
end

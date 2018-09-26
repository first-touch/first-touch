module V1
  module Order
    module Representer
      class Empty < Representable::Decorator
        include Representable::JSON
      end
    end
  end
end

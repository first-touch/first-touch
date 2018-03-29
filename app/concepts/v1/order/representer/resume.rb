module V1
  module Order
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON
        property :filename
      end
    end
  end
end
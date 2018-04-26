module V1
  module Team
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :teams, decorator: Simplified
      end
    end
  end
end

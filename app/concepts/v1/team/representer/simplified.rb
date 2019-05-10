module V1
  module Team
    module Representer
      class Simplified < Representable::Decorator
        include Representable::JSON

        property :team_name
        property :id

        property :competitions, representer: ::V1::Competition::Representer::Simplified
      end
    end
  end
end

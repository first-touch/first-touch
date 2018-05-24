module V1
  module Team
    module Representer
      class Simplified < Representable::Decorator
        include Representable::JSON

        property :team_name

        property :competitions, getter: lambda { |represented:, **|
            ::V1::Competition::Representer::Index.new(
            represented.competitions
            )
        }
      end
    end
  end
end

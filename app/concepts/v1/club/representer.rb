module V1
  module Club
    module Representer
      class Countries < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :countries do
          property :country_name
          property :country_code
        end
      end
    end
  end
end

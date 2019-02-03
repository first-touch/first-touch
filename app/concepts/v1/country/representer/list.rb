module V1
  module Country
    module Representer
      class List < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :countries do
          property :country_name
          property :country_code
        end
      end
    end
  end
end

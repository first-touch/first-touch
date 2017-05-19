module Api
  module V1
    module Club
      module Representer
        class Show < Representable::Decorator
          include Representable::JSON

          property :id
          property :name
          property :city
          property :country_code
        end

        class Search < Representable::Decorator
          include Representable::JSON

          collection :to_a, as: :clubs, decorator: Show
        end
      end
    end
  end
end

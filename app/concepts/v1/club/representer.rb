module V1
  module Club
    module Representer
      class Show < Representable::Decorator
        include Representable::JSON

        property :id
        property :name
        property :city
        property :country_code
        property :has_owner, exec_context: :decorator

        def has_owner
          !represented.account_owner_id.nil?
        end
      end

      class Search < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :clubs, decorator: Show
      end

      class Country < Representable::Decorator
        include Representable::JSON

        property :country_name
        property :country_code
      end

      class Countries < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :countries, decorator: Country
      end
    end
  end
end

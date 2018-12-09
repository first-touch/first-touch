module V1
  module Club
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON
        property :id
        property :name
        property :city
        property :country_code
        property :owner?, exec_context: :decorator

        def owner?
          !represented.account_owner_id.nil?
        end
      end
    end
  end
end

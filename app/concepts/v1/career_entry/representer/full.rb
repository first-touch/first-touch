module V1
  module CareerEntry
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :start_date
        property :end_date
        property :club, extend: ::V1::Club::Representer::Full
        property :role
      end
    end
  end
end

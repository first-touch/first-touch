module V1
  module Order
    module Representer
      class Show < Representable::Decorator
        include Representable::JSON
        property :id
        property :status
        property :price
        property :customer_id
        property :report
      end
    end
  end
end
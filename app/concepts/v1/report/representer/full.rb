module V1
  module Report
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :user_id
        property :headline
        property :price
      end
    end
  end
end

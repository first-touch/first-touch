module V1
  module Network
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :user, decorator: ::V1::User::Representer::Search
        property :connected_to, decorator: ::V1::User::Representer::Search
      end

      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :network, decorator: Full
      end
    end
  end
end

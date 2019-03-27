module V1
  module Network
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :network, decorator: ::V1::User::Representer::Search
      end
    end
  end
end

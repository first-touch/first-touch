require_relative 'show'
module V1
  module Club
    module Representer
      class Search < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :clubs, decorator: Show
      end
    end
  end
end

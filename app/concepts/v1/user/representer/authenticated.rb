module V1
  module User
    module Representer
      class Authenticated < Representable::Decorator
        include Representable::JSON

        property :auth_token
        property :clubs_token
      end
    end
  end
end

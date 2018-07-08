module V1
  module User
    module Representer
      class Authenticated < Representable::Decorator
        include Representable::JSON

        property :email
        property :authentication_token
      end
    end
  end
end

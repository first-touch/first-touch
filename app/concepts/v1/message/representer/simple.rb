module V1
  module Message
    module Representer
      class Simple < Representable::Decorator
        include Representable::JSON

        property :message_body
        property :message_recipient
        property :creator
      end
    end
  end
end

module V1
  module Message
    module Representer
      class Simple < Representable::Decorator
        include Representable::JSON

        property :message_body
        property :message_recipient, class: MessageRecipient do
          property :recipient_id
        end
        property :creator, class: User do
          property :id
        end
      end
    end
  end
end

module V1
  module Chat
    module Representer
      class FullChat < Representable::Decorator
        include Representable::JSON

        property :chat_with, decorator: ::V1::User::Representer::SelfProfile
        property :messages
      end
    end
  end
end

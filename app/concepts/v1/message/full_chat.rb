module V1
  module Message
    class FullChat < Disposable::Twin
      property :chat_with, virtual: true
      property :messages, virtual: true
    end
  end
end

class Api::V1::MessagesController
  class Chat
    include ActiveModel::Serialization

    attr_accessor :chat_with,
                  :last_message,
                  :read

    def initialize(chat_attrs)
      @last_message = chat_attrs[:last_message]

      recipient = @last_message.message_recipient
      if recipient.recipient_id == chat_attrs[:current_user].id
        @read = true
        @chat_with = last_message.creator
      else
        @read = !recipient.read_at.nil?
        @chat_with = recipient.recipient
      end
    end
  end
end

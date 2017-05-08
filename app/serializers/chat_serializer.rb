class ChatSerializer < ActiveModel::Serializer
  attributes :read
  has_one :chat_with, serializer: Users::SearchSerializer
  has_one :last_message, serializer: MessageSerializer
end

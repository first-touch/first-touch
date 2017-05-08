class MessageSerializer < ActiveModel::Serializer
  attributes :id, :subject, :message_body
end

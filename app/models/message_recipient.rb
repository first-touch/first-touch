class MessageRecipient < ApplicationRecord
  belongs_to :message
  belongs_to :recipient, class_name: 'User', foreign_key: :recipient_id
end

class Message < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_one :message_recipient

  validates_presence_of :message_body, :creator_id
  delegate :recipient, to: :message_recipient
end

class Message < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_one :message_recipient

  delegate :recipient, to: :message_recipient

  validates_presence_of :message_body, :creator_id

  accepts_nested_attributes_for :message_recipient
end

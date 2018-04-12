class Message < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :creator_id
  has_one :message_recipient
  has_many :images, as: :imageable, inverse_of: :imageable, dependent: :destroy

  validates_presence_of :message_body, :creator_id
  delegate :recipient, to: :message_recipient

  accepts_nested_attributes_for :images,
                                allow_destroy: true,
                                reject_if: lambda { |attr|
                                  attr['id'].blank? && attr['file'].blank?
                                }

  accepts_nested_attributes_for :message_recipient
end

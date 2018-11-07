# require 'reform/form/validation/unique_validator'

module V1
  module Message
    module Contract
      class Create < Reform::Form
        property :message_body
        property :message_recipient
        property :creator

        validates :message_body,
                  :message_recipient,
                  :creator,
                  presence: true
      end
    end
  end
end

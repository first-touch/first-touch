# require 'reform/form/validation/unique_validator'

module V1
  module Connection
    module Contract
      class Create < Reform::Form
        property :user_id
        property :connected_to_id
        property :status

        validates :user_id,
                  :connected_to_id,
                  :status,
                  presence: true

        validates :status,
                  inclusion: {
                    in: [::Connection::PENDING, ::Connection::ACCEPTED],
                    message: 'should be pending or accepted'
                  }
      end
    end
  end
end

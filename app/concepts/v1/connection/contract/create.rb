require 'reform/form/validation/unique_validator'

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
      end
    end
  end
end

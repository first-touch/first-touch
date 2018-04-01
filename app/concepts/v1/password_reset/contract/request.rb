require 'reform/form/validation/unique_validator'

module V1
  module PasswordReset
    module Contract
      class Request < Reform::Form
        property :user
        property :token
        property :expires_at

        validates :user, :token, presence: true
      end
    end
  end
end

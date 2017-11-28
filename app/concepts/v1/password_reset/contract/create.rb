require 'reform/form/validation/unique_validator'

module V1
  module PasswordReset
    module Contract
      class Create < Reform::Form
        property :email, virtual: true
        property :user
        property :token
        property :expires_at

        validates :email, :user, :token, :expires_at, presence: true
      end
    end
  end
end

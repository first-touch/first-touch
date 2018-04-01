require 'reform/form/validation/unique_validator'

module V1
  module PasswordReset
    module Contract
      class Form < Reform::Form
        property :user, virtual: true
        property :token
        property :password
        property :password_confirmation

        validates :user, :token, presence: true
      end
    end
  end
end

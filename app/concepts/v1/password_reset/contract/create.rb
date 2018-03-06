require 'reform/form/validation/unique_validator'
require 'bcrypt'

module V1
  module PasswordReset
    module Contract
      class Create < Reform::Form
        property :user
        property :token
        property :expires_at

        validates :user, :token, presence: true
      end
    end
  end
end

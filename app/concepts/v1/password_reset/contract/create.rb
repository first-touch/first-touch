require 'reform/form/validation/unique_validator'

module V1
  module PasswordReset
    module Contract
      class Create < Reform::Form
        property :email, virtual: true

        validates :email, presence: true
        validate :find_user_by_email

        def find_user_by_email
          user = User.find_by(email: email)
          errors.add(:email, :not_found) unless user
        end
      end
    end
  end
end

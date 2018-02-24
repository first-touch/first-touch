require 'reform/form/validation/unique_validator'

module V1
  module User
    module Contract
      class Register < Reform::Form
        property :email
        property :password
        property :password_confirmation
        property :personal_profile,
                 populator: ->(_options) {
                   self.personal_profile = ::PersonalProfile.new
                 },
                 form: ::V1::PersonalProfile::Contract::Create
        validates :email,
                  :password,
                  :password_confirmation,
                  :personal_profile,
                  presence: true

        validates :email, unique: true
        validate :role_is_registerable

        def role_is_registerable
          current_role = model.roles.first.name
          return if FirstTouch::REGISTERABLE_ROLE_NAMES.include? current_role
          errors.add(:roles, I18n.t('user.invalid_role'))
        end
      end
    end
  end
end

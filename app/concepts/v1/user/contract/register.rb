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
        property :club_ids
        validates :email,
                  :password,
                  :password_confirmation,
                  :personal_profile,
                  presence: true

        validate :unique_email
        validate :role_is_registerable

        def unique_email
          return true unless model.new_record?
          return true unless ::User.exists?(email: email.downcase)
          errors.add(:email, I18n.t('user.existing_email'))
        end

        def role_is_registerable
          current_role = model.roles.first.name
          return true if FirstTouch::REGISTERABLE_ROLE_NAMES.include? current_role
          errors.add(:roles, I18n.t('user.invalid_role'))
        end
      end
    end
  end
end

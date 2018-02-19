require 'reform/form/validation/unique_validator'

module V1
  module User
    module Contract
      class Register < Reform::Form
        property :email
        property :password
        property :password_confirmation
        property :personal_profile do
          property :first_name
          property :middle_name
          property :last_name
          property :birthday
          property :nationality_country_code
          property :residence_country_code
          property :weight
          property :height
          property :preferred_foot
          property :playing_position
          property :pro_status

          validates :first_name,
                    :last_name,
                    :birthday,
                    presence: true
        end

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

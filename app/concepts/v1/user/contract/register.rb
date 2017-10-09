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
                    presence: :true
        end

        validates :email,
                  :password,
                  :password_confirmation,
                  :personal_profile,
                  presence: :true

        validates :email, unique: :true
      end
    end
  end
end

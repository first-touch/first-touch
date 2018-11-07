# require 'reform/form/validation/unique_validator'

module V1
  module User
    module Contract
      class Update < Reform::Form
        property :personal_profile,
                 populate_if_empty: ::PersonalProfile,
                 form: ::V1::PersonalProfile::Contract::Create
      end
    end
  end
end

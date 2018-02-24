require 'reform/form/validation/unique_validator'

module V1
  module PersonalProfile
    module Contract
      class Create < Reform::Form
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
    end
  end
end

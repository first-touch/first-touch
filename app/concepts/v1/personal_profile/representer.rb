module V1
  module PersonalProfile
    module Representer
      class Simplified < Representable::Decorator
        include Representable::JSON

        property :id
        property :first_name
        property :middle_name
        property :last_name
        property :birthday
        property :nationality_country_code
        property :residence_country_code
        property :place_of_birth
        property :weight
        property :height
        property :preferred_foot
        property :languages
        property :playing_positions
        property :pro_status
        property :total_caps
        property :biography
        property :avatar_url
      end
    end
  end
end

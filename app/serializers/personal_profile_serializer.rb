class PersonalProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :middle_name, :last_name,
             :birthday, :nationality_country_code,
             :residence_country_code, :place_of_birth,
             :weight, :height, :preferred_foot,
             :languages
end

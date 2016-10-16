class PersonalProfileSerializer < ActiveModel::Serializer
  attributes :first_name, :middle_name, :last_name,
             :birthday, :nationality_country_code,
             :residence_country_code, :summary,
             :achievements, :languages
end

FactoryBot.define do
  factory :personal_profile do
    user
    first_name { Faker::Name.first_name }
    middle_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    birthday { Faker::Date.backward(10000) }
    nationality_country_code "PT"
    residence_country_code "SP"
    place_of_birth "Sao joao do campo"
    weight { Faker::Number.decimal(2) }
    height { Faker::Number.decimal(2) }
    preferred_foot { ["Right", "Left", "Both"].sample }
  end
end

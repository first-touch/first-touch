FactoryBot.define do
  factory :user do
    email             { Faker::Internet.email }
    password          { Faker::Internet.password }
    last_logout_at    { 100.years.ago }
    roles { [Role.find_or_create_by(name: FirstTouch::REGISTERABLE_ROLE_NAMES.first)] }

    trait :with_personal_profile do
      personal_profile { association(:personal_profile) }
    end
  end
end

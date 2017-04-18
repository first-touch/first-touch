FactoryGirl.define do
  factory :user do
    email             { Faker::Internet.email }
    password          { Faker::Internet.password }

    trait :with_personal_profile do
      personal_profile { association(:personal_profile) }
    end
  end
end

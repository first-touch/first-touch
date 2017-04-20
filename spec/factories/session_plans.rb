FactoryGirl.define do
  factory :session_plan do
    user
    name { Faker::Hipster.word }
    tags { Faker::Hipster.words }
  end
end

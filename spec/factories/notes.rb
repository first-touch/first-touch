FactoryGirl.define do
  factory :note do
    user
    name { Faker::Hipster.word }
    tags { Faker::Hipster.words }
  end
end

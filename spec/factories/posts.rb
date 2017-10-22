FactoryGirl.define do
  factory :post do
    content { Faker::Hacker.say_something_smart }
    association :author, factory: :user
  end
end

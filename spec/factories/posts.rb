FactoryGirl.define do
  factory :post do
    content { Faker::Hacker.say_something_smart }
    user
  end
end

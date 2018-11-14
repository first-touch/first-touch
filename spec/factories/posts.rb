FactoryBot.define do
  factory :post do
    content { Faker::Hacker.say_something_smart }
    author { create :user }
  end
end

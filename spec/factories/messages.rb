FactoryBot.define do
  factory :message do
    subject { Faker::Company.buzzword }
    message_body { Faker::Hacker.say_something_smart }
    association :creator, factory: :user
  end
end

def message(options={})
  FactoryBot.create :message, options
end

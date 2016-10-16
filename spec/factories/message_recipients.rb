FactoryGirl.define do
  factory :message_recipient do
    association :recipient, factory: :user
    message
  end
end

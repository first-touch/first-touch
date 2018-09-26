FactoryBot.define do
  factory :order do
    user nil
    customer_id 1
    price 1
    report nil
    status "accepted"
  end
end

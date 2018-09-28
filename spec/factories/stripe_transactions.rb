FactoryBot.define do
  factory :stripe_transaction do
    stripe_id "MyText"
    refounded false
    refound_at "2018-05-10"
    order nil
    type_transaction "MyText"
  end
end

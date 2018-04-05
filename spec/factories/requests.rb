FactoryGirl.define do
  factory :request do
    type_request "MyText"
    min_price 1
    max_price 1
    user nil
    deadline "2018-04-04"
    status "MyText"
    meta_data ""
  end
end

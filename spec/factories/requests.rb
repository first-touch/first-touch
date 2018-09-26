FactoryGirl.define do
  factory :request do
    type_request "MyText"
    user nil
    deadline "2018-04-04"
    status "MyText"
    meta_data ""
  end
end

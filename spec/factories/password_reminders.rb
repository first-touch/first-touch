FactoryGirl.define do
  factory :password_reminder do
    token "MyString"
    user nil
    expires_at "2017-11-20 15:33:12"
  end
end

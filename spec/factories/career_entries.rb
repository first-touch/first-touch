FactoryGirl.define do
  factory :career_entry do
    user
    start_date { Faker::Date.between(10.years.ago, 2.years.ago) }
    end_date { Faker::Date.between(2.years.ago, Date.today) }
  end
end

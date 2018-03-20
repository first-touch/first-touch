FactoryGirl.define do
  factory :report do
    headline "The new maradona"
    index true
    type_report "player"
    version 1
    user
    price 1
    club nil
    player 1
  end
end

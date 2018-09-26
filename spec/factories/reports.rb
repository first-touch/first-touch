FactoryGirl.define do
  factory :report do
    user
    headline "The new maradona"
    status "indexed"
    type_report "player"
    price 1
    club nil
    player_id nil
  end
end

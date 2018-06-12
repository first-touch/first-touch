FactoryGirl.define do
  factory :post do
    transient do
      current_user do
        res = V1::User::Register.(
          email: 'test@bananas.com',
          password: '123123',
          password_confirmation: '123123',
          role_name: 'manager',
          personal_profile: {
            first_name: 'Test',
            last_name: 'Bananas',
            birthday: '10/01/1989'
          }
        )
        res['model']
      end
    end
    content { Faker::Hacker.say_something_smart }
  end

  initialize_with do
    res = V1::Post::Create.({ post: attributes }, current_user: current_user)
    puts res.inspect if res.failure?
    res['model']
  end
end

require 'rails_helper'

RSpec.describe V1::Post::PersonalFeed do
  let!(:current_user) do
    res = V1::User::Register.(
      email: 'test@banaas.com',
      password: '123123',
      password_confirmation: '123123',
      role_name: 'director',
      personal_profile: {
        first_name: 'Test',
        last_name: 'Bananas',
        birthday: '10/01/1989'
      }
    )
    res['model']
  end
  let!(:user1) do
    res = V1::User::Register.(
      email: 'test1@banaas.com',
      password: '123123',
      password_confirmation: '123123',
      role_name: 'player',
      personal_profile: {
        first_name: 'Test 1',
        last_name: 'Bananas',
        birthday: '10/01/1989'
      }
    )
    res['model']
  end
  let!(:user2) do
    res = V1::User::Register.(
      email: 'test2@banaas.com',
      password: '123123',
      password_confirmation: '123123',
      role_name: 'scout',
      personal_profile: {
        first_name: 'Test 2',
        last_name: 'Bananas',
        birthday: '10/01/1989'
      }
    )
    res['model']
  end
  let(:operation) { V1::Post::PersonalFeed.({}, current_user: current_user) }

  before do
    current_user.follow(user1)
    ::V1::Post::Create.(
      { post: { content: 'personal post' } }, current_user: current_user
    )
    ::V1::Post::Create.(
      { post: { content: 'post by followed user 1' } }, current_user: user1
    )
    ::V1::Post::Create.(
      { post: { content: 'post by followed user 2' } }, current_user: user2
    )
  end

  it 'builds the feed based on his own posts + people he follows' do
    expect(operation.success?).to eq true
    feed = operation['models']
    expect(feed.length).to eq 2
    expect(feed[0].content).to eq 'post by followed user 1'
    expect(feed[1].content).to eq 'personal post'
  end
end

require 'rails_helper'

RSpec.describe V1::Post::Create do
  let(:current_user) do
    res = V1::User::Register.(
      email: 'test@banaas.com',
      password: '123123',
      password_confirmation: '123123',
      personal_profile: {
        first_name: 'Test',
        last_name: 'Bananas',
        birthday: '10/01/1989'
      }
    )
    res['model']
  end
  let(:operation) { V1::Post::Create.(params, current_user: current_user) }

  describe 'when the user is posting on a user behalf' do
    let(:params) do
      {
        post: {
          content: 'hello'
        },
        user_id: author.id
      }
    end
    describe 'when the user is allowed' do
      let(:author) { current_user }
      it 'persists the post' do
        expect(operation.success?).to eq true
        post = operation['model']
        expect(post).to be_persisted
        expect(post.author).to eq current_user
        expect(post.content).to eq 'hello'
      end
    end

    describe 'when the user is not allowed' do
      let(:author) do
        res = V1::User::Register.(
          email: 'author@banaas.com',
          password: '123123',
          password_confirmation: '123123',
          personal_profile: {
            first_name: 'Test',
            last_name: 'Bananas',
            birthday: '10/01/1989'
          }
        )
        res['model']
      end

      it 'returns an error' do
        expect(operation.success?).to eq false
        expect(operation['result.policy.failure']).to eq :unauthorized
      end
    end
  end

  describe 'when the user is posting on a club behalf' do
    let(:params) do
      {
        post: {
          content: 'hello'
        },
        club_id: club.id
      }
    end
    describe 'when the user is allowed' do
      let(:club) { FactoryGirl.create :club, account_owner: current_user }

      it 'persists the post' do
        expect(operation.success?).to eq true
        post = operation['model']
        expect(post).to be_persisted
        expect(post.author).to eq club
        expect(post.content).to eq 'hello'
      end
    end

    describe 'when the user is not allowed' do
      let(:club) { FactoryGirl.create :club, account_owner: other_user }
      let(:other_user) do
        res = V1::User::Register.(
          email: 'author@banaas.com',
          password: '123123',
          password_confirmation: '123123',
          personal_profile: {
            first_name: 'Test',
            last_name: 'Bananas',
            birthday: '10/01/1989'
          }
        )
        res['model']
      end

      it 'returns an error' do
        expect(operation.success?).to eq false
        expect(operation['result.policy.failure']).to eq :unauthorized
      end
    end
  end
end

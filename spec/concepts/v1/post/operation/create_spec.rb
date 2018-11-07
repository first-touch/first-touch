require 'rails_helper'

RSpec.describe V1::Post::Create do
  let(:current_user) do
    res = V1::User::Register.(
      params: {
        email: 'test@banaas.com',
        password: '123123',
        role_name: 'director',
        password_confirmation: '123123',
        personal_profile: {
          first_name: 'Test',
          last_name: 'Bananas',
          birthday: '10/01/1989'
        }
      }
    )
    res['model']
  end
  let(:club) do
    res = V1::Club::Create.(
      params: {
        club: {
          name: 'Club',
          city: 'City',
          country_code: 'PT',
          account_owner_id: current_user.id
        }
      }
    )
    res['model']
  end

  let(:operation) { V1::Post::Create.(params, current_user: author) }

  describe 'when the user is posting' do
    let(:author) { current_user }
    let(:params) do
      {
        post: {
          content: 'hello'
        }
      }
    end
    describe 'when the user is allowed' do
      it 'persists the post' do
        expect(operation.success?).to eq true
        post = operation['model']
        expect(post).to be_persisted
        expect(post.author).to eq current_user
        expect(post.content).to eq 'hello'
      end
    end
  end

  describe 'when the club is posting' do
    let(:author) { club }
    let(:params) do
      {
        post: {
          content: 'hello'
        }
      }
    end

    it 'persists the post' do
      expect(operation.success?).to eq true
      post = operation['model']
      expect(post).to be_persisted
      expect(post.author).to eq club
      expect(post.content).to eq 'hello'
    end
  end
end

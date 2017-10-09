require 'rails_helper'

RSpec.describe V1::Post::Create do
  # FIXME: Replace the use of factory girl with user create operation
  let(:current_user) { FactoryGirl.create :user }
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
      let(:author) { FactoryGirl.create :user }
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
      let(:other_user) { FactoryGirl.create :user }

      it 'returns an error' do
        expect(operation.success?).to eq false
        expect(operation['result.policy.failure']).to eq :unauthorized
      end
    end
  end
end

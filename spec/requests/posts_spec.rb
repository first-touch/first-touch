require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:existing_user) do
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

  before do
    # FIXME: Replace this logic when Tyrant is in place
    allow(AuthorizeApiRequest).to receive(:call).and_return mocked_result
    request
  end

  describe 'Post Creation' do
    let(:request) do
      post "/api/v1/#{on_behalf}/#{existing_user.id}/posts", params: params
    end

    describe 'when posting is a user' do
      let(:mocked_result) do
        instance_double(SimpleCommand, result: existing_user)
      end
      let(:on_behalf) { 'users' }
      let(:params) do
        {
          post: {
            content: 'hello'
          }
        }
      end

      it 'it creates a post associated with the user' do
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:created)
      end
    end
  end
end

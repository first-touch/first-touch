require 'rails_helper'

RSpec.describe 'Notes', type: :request do
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
  let(:mocked_result) do
    instance_double(SimpleCommand, result: existing_user)
  end

  before do
    # FIXME: Replace this logic when final auth logic is in place
    allow(AuthorizeApiRequest).to receive(:call).and_return mocked_result
    request
  end

  describe 'Note Index' do
    let(:request) do
      get api_v1_notes_url
    end

    it 'it gets all users notes' do
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'Note Creation' do
    let(:request) do
      post api_v1_notes_url, params: {
        note: {
          name: 'hello',
          content: 'here too'
        }
      }
    end

    it 'it creates a note associated with the user' do
      expect(response.content_type).to eq('application/json')
      expect(response).to have_http_status(:created)
    end
  end
end

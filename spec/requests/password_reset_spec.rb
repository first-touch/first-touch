require 'rails_helper'

RSpec.describe 'Password Reset', type: :request do
  let!(:user) do
    res = V1::User::Register.(
      email: 'test@banaas.com',
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

  describe 'Start Process' do
    let(:request) do
      get api_v1_password_request_url, params: params
    end

    before do
      request
    end

    describe 'When requesting with an invalid email' do
      let(:params) { { email: 'wrong@banaas.com' } }
      it 'response gives an error' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'When requesting with a valid email' do
      let(:params) { { email: 'test@banaas.com' } }

      it 'response is successful' do
        expect(response).to have_http_status(:ok)
      end
    end
  end


  let(:secure_token) { "ABC123123" }
  let(:now) { DateTime.now }
  let(:request_reset) { V1::PasswordReset::Request.({email: 'test@banaas.com'}) }
  before do
    allow(SecureRandom).to receive(:urlsafe_base64).and_return(secure_token)
    Timecop.freeze(now) do
      request_reset
    end
  end

  describe 'Update' do
    describe 'When user clicks link with invalid reset token' do
      let(:get) do
        get api_v1_password_update_url, params: {token: '111111111'}
      end
      it 'token is invalid' do
        expect(response).to have_http_status(:not_found)
      end
    end

    describe 'When user clicks link with valid reset token' do
      let(:get) do
        get api_v1_password_update_url, params: {token: secure_token}
      end
      it 'form to update password is rendered' do
        expect(response).to have_http_status(:ok)
      end
    end

    describe 'When user submits form' do
      let(:params) {
        {
          token: secure_token,
          password: 'newpassword',
          password_confirmation: 'newpassword'
        }
      }
      let(:post) do
        request_reset
        post api_v1_password_update_url, params: params
      end

      it 'it updates user password' do
        expect(response).to have_http_status(:ok)
      end
    end

  end
end

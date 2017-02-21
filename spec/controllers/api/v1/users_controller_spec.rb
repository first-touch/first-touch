require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  let(:response_body) { JSON.parse response.body }
  let(:response_code) { response.response_code }

  describe 'POST register' do
    let(:email) { 'ze@firsttouch.io' }
    let(:first_name) { 'Ze' }
    let(:last_name) { 'Marreco' }
    let(:birthday) { 80.years.ago.to_date }

    let(:do_request) do
      post :register, params: {
             email: email,
             password: '123123',
             password_confirmation: '123123',
             personal_profile_attributes: {
               first_name: first_name,
               last_name: last_name,
               birthday: birthday.to_s
             }
           }
    end

    before do
      do_request
    end

    describe 'when the attributes are all present' do
      it 'creates the user' do
        expect(response_code).to eq 200
        expect(User.count).to eq 1
        new_user = User.first
        expect(new_user.email).to eq email
        expect(new_user.personal_profile.first_name).to eq first_name
        expect(new_user.personal_profile.last_name).to eq last_name
        expect(new_user.personal_profile.birthday).to eq birthday
      end
    end
  end

  describe 'GET user' do
    let(:existing_user) { create :user }
    let(:calvin) { create :user }
    let(:do_request) { get :show, params: { id: existing_user.id } }
    let(:mock_auth) { AuthorizeApiRequest.new }

    before do
      allow(mock_auth).to receive(user).and_return(calvin)
      do_request
    end

    it 'returns the full user profile' do
      expect(response_code).to eq 200
      expect(response_body).to include_json existing_user.as_json
    end
  end
end

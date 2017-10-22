# require 'rails_helper'
#
# RSpec.describe Api::V1::AuthenticationController, type: :controller do
#   let!(:calvin) { create :user, email: 'calvin@firsttouch.io', password: '123123123', last_logout_at: Time.at(0) }
#   let(:response_body) { JSON.parse response.body }
#   let(:response_code) { response.response_code }
#
#   before do
#     Timecop.freeze(DateTime.now)
#     allow(JsonWebToken).to receive(:encode).and_return("12")
#     allow(JsonWebToken).to receive(:decode).and_return({ user_id: calvin.id, digest: calvin.password_digest, last_logout: 0 })
#     do_request
#   end
#
#   describe 'POST authenticate' do
#     let(:do_request) { post :authenticate, params: {
#                               email: 'calvin@firsttouch.io',
#                               password: '123123123'
#                             }}
#
#     it 'authenticates the user' do
#       expect(response_code).to eq 200
#     end
#
#     it 'returns the auth_token' do
#       expect(response_body).to include_json({
#                                               "auth_token": "12"
#                                             })
#     end
#   end
#
#   describe 'POST logout' do
#     let(:do_request) { post :logout }
#
#     it 'updates the last_logout_at' do
#       expect(response_code).to eq 200
#       expect(calvin.reload.last_logout_at.to_i).to eq DateTime.now.to_i
#     end
#   end
#
# end

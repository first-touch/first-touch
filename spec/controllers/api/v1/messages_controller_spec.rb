require 'rails_helper'

RSpec.describe Api::V1::MessagesController, type: :controller do
  let(:calvin) { create :user }
  let(:hobbes) { create :user }
  let(:response_body) { JSON.parse response.body }
  let(:response_code) { response.response_code }

  describe 'GET index' do
    let(:do_request) { get :index }

    it_behaves_like 'authenticated request'

    describe 'when the user is authenticated' do
      let!(:message_to_calvin) do
        create :message_recipient,
               recipient_id: calvin.id,
               message: message(creator_id: hobbes.id)
      end

      let!(:message_to_hobbes) do
        create :message_recipient,
               recipient_id: hobbes.id,
               message: message(creator_id: calvin.id)
      end

      let!(:message_two_to_calvin) do
        create :message_recipient,
               recipient_id: calvin.id,
               message: message(creator_id: hobbes.id)
      end

      let!(:message_three_to_calvin) do
        create :message_recipient,
               recipient_id: calvin.id,
               message: message(creator_id: hobbes.id)
      end

      before do
        do_request
      end

      it 'renders the inbox json' do
        expect(response_code).to eq 200
        expect(response_body['inbox'].keys).to eq([calvin.id.to_s])
        expect(response_body['inbox'][calvin.id.to_s].length).to eq 4
      end
    end
  end

  describe 'POST create' do
    let(:body)       { 'hello world' }
    let(:do_request) do
      post :create, params: {
             message: {
               message_body: body,
               message_recipient_attributes: {
                 recipient_id: calvin.id
               }
             }
           }
    end

    it_behaves_like 'authenticated request'

    describe 'when the user is logged in' do
      it 'creates the message and message recipient' do
        expect { do_request }.to change { Message.count }.by 1
      end

      it 'defines the correct users as creator and recipient' do
        do_request
        expect(response_code).to eq 201
        new_message = Message.last
        expect(new_message.creator_id).to eq hobbes.id
        expect(new_message.message_recipient.recipient_id).to eq calvin.id
      end
    end
  end
end

require 'rails_helper'

RSpec.describe V1::Message::Create do
  let(:current_user) do
    res = V1::User::Register.(
      params: {
        email: 'test@banaas.com',
        password: '123123',
        password_confirmation: '123123',
        role_name: 'director',
        personal_profile: {
          first_name: 'Test',
          last_name: 'Bananas',
          birthday: '10/01/1989'
        }
      }
    )
    res[:model]
  end
  let(:recipient) { create :user }
  let(:operation) { V1::Message::Create.(params: params, current_user: current_user) }

  describe 'when all neccessary params are filled' do
    let(:params) do
      {
        recipient_id: recipient.id,
        message_body: 'my friend',
        subject: 'wassup'
      }
    end

    it 'creates the message' do
      expect(operation.success?).to eq true

      message = Message.last
      expect(message.creator).to eq current_user
      expect(message.recipient).to eq recipient
      expect(message.message_body).to eq params[:message_body]
      expect(message.subject).to eq params[:subject]
    end
  end

  describe 'when recipient id is not valid' do
    let(:params) do
      {
        recipient_id: 123123123,
        message_body: 'my friend',
        subject: 'wassup'
      }
    end

    it 'returns an error' do
      expect(operation.success?).to eq false

      error_message = "Recipient with ID(123123123) can't be found"
      expect(operation[:errors]).to eq error_message
    end
  end

  describe 'when message body is empty' do
    let(:params) do
      {
        recipient_id: recipient.id,
        message_body: nil,
        subject: 'wassup'
      }
    end

    it 'returns an error' do
      expect(operation.success?).to eq false

      operation_errors = operation["contract.default"].errors.messages
      error_message = "can't be blank"

      expect(operation_errors[:message_body][0]).to eq error_message
    end
  end
end

require 'rails_helper'
require 'byebug'

RSpec.describe V1::PasswordReset::Request do
  let(:calvin) do
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

  let(:params) do
    { email: 'test@banaas.com' }
  end
  let(:operation) { V1::PasswordReset::Request.(params) }

  describe 'when user provides email for password reset' do
    it 'generates reset token' do
      byebug
      expect(operation.success?).to eq true
      reminder = operation['model']
      expect(reminder).to be_persisted
      expect(reminder.user).to eq calvin
      expect(reminder.token).to be_an_instance_of(SecureRandom)
      expect(reminder.expires_at).to be_an_instance_of(Time)
    end
  end

end

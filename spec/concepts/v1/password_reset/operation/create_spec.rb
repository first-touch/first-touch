require 'rails_helper'

RSpec.describe V1::PasswordReset::Create do
  let!(:calvin) do
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

  let(:params) { { email: 'test@banaas.com' } }
  let(:secure_token) { "ABC123123" }
  let(:now) { DateTime.now }
  let(:operation) { V1::PasswordReset::Request.(params) }

  before do
    allow(SecureRandom).to receive(:urlsafe_base64).and_return(secure_token)
    Timecop.freeze(now) do
      operation
    end
  end

  describe 'when user provides email' do
    it 'generates reset token' do
      expect(operation.success?).to eq true
      reminder = operation['model']
      expect(reminder).to be_persisted
      expect(reminder.user).to eq calvin
      expect(reminder.token).to eq secure_token
      expect(reminder.expires_at.to_i).to eq (now + 1.hour).to_i
      mail = ActionMailer::Base.deliveries.last
      expect(mail[:to].to_s).to eq(params[:email])
      expect(mail[:subject].to_s).to eq("FirstTouch Reset Password")
    end
  end

end

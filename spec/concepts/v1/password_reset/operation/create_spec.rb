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

  let(:params) do
    { email: 'test@banaas.com' }
  end
  let(:operation) do
    # calvin.reload
    res = V1::PasswordReset::Create.(params)
    debugger
    res
  end

  describe 'when user provides email' do
    it 'generates reset token' do
      debugger
      # expect(operation.success?).to eq true
      reminder = operation['model']
      expect(reminder).to be_persisted
      expect(reminder.user).to eq calvin
      expect(reminder.token).to be_an_instance_of(SecureRandom)
      expect(reminder.expires_at).to be_an_instance_of(Time)
    end
  end

end

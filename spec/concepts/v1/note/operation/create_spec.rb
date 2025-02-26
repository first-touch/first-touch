require 'rails_helper'

RSpec.describe V1::Note::Create do
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
  let(:operation) { V1::Note::Create.(params: params, current_user: current_user) }

  describe 'when there is a user' do
    let(:params) do
      {
        note: {
          name: 'note name',
          content: 'amazing note'
        }
      }
    end
    it 'persists the note' do
      expect(operation.success?).to eq true
      note = operation[:model]
      expect(note).to be_persisted
      expect(note.user).to eq current_user
      expect(note.content).to eq 'amazing note'
      expect(note.name).to eq 'note name'
    end
  end
end

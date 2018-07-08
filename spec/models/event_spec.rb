require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:organizer) }
    it { is_expected.to belong_to(:opponent) }
  end

  describe 'validations' do
    it { is_expected.to define_enum_for(:evt_type).with(Event::EVT_TYPES) }
  end

  describe 'scopes' do
    describe 'in_future' do
      before do
        Timecop.freeze
      end

      let(:current_user) do
        res = V1::User::Register.(
          email: 'test@banaas.com',
          password: '123123',
          password_confirmation: '123123',
          role_name: 'scout',
          personal_profile: {
            first_name: 'Test',
            last_name: 'Bananas',
            birthday: '10/01/1989'
          }
        )
        res['model']
      end
      let!(:club) { FactoryBot.create :club, account_owner: current_user }
      let(:params_before) do
        {
          event: {
            start_date: DateTime.yesterday,
            evt_type: 'friendly_match'
          }
        }
      end
      let(:params_now) do
        {
          event: {
            start_date: DateTime.now,
            evt_type: 'friendly_match'
          }
        }
      end
      let(:params_after) do
        {
          event: {
            start_date: DateTime.tomorrow,
            evt_type: 'friendly_match'
          }
        }
      end

      let!(:events) do
        ::V1::Event::Create.(params_before, current_user: current_user)
        ::V1::Event::Create.(params_now, current_user: current_user)
        ::V1::Event::Create.(params_after, current_user: current_user)
      end

      it 'returns max 10 events happening now or after' do
        events = ::Event.in_future
        expect(events.count).to eq 2
      end
    end
  end
end

require 'rails_helper'

RSpec.describe V1::Event::Create do
  let(:current_user) do
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
  let(:opponent) { FactoryGirl.create :club }
  let(:operation) { V1::Event::Create.(params, current_user: current_user) }
  let(:start_date) { 6.months.from_now }
  let(:end_date) { 6.months.from_now + 1.hour }
  let(:params) do
    {
      event: {
        evt_type: 'friendly_match',
        opponent_id: opponent.id,
        name: 'Amazing match',
        venue: 'At my place',
        start_date: start_date.to_s,
        end_date: end_date.to_s,
        description: 'This will be splendid'
      }
    }
  end

  describe 'when the user is allowed to create an event' do
    let!(:club) { FactoryGirl.create :club, account_owner: current_user }

    it 'persists the event' do
      expect(operation.success?).to eq true
      event = operation['model']
      expect(event).to be_persisted
      expect(event.evt_type).to eq 'friendly_match'
      expect(event.organizer).to eq club
      expect(event.opponent).to eq opponent
      expect(event.name).to eq 'Amazing match'
      expect(event.venue).to eq 'At my place'
      evt_date = event.start_date.strftime(Date::DATE_FORMATS[:iso_date_time])
      expected_date = start_date.strftime(Date::DATE_FORMATS[:iso_date_time])
      expect(evt_date).to eq expected_date
      evt_date = event.end_date.strftime(Date::DATE_FORMATS[:iso_date_time])
      expected_date = end_date.strftime(Date::DATE_FORMATS[:iso_date_time])
      expect(evt_date).to eq expected_date
      expect(event.description).to eq 'This will be splendid'
    end
  end

  describe 'when the user is not allwoed to create an event' do
    it 'returns an error' do
      expect(operation.success?).to eq false
      expect(operation['result.policy.failure']).to eq :unauthorized
    end
  end
end

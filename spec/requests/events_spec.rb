require 'rails_helper'

RSpec.describe 'Events', type: :request do
  let!(:club) do
    FactoryGirl.create :club, account_owner_id: existing_user.id
  end
  let!(:opponent) do
    FactoryGirl.create :club
  end
  let!(:existing_user) do
    res = V1::User::Register.(
      email: 'test@banaas.com',
      password: '123123',
      role_name: 'director',
      password_confirmation: '123123',
      personal_profile: {
        first_name: 'Test',
        last_name: 'Bananas',
        birthday: '10/01/1989'
      }
    )
    res['model']
  end
  let(:mocked_result) do
    instance_double(SimpleCommand, result: existing_user)
  end
  let(:start_date) { 6.months.from_now }
  let(:end_date) { 6.months.from_now + 1.hour }
  let!(:existing_event) do
    res = V1::Event::Create.(params, current_user: existing_user)
    res['model']
  end

  before do
    # FIXME: Replace this logic when Tyrant is in place
    allow(AuthorizeApiRequest).to receive(:call).and_return mocked_result
    request
  end

  describe 'Event Creation' do
    let(:request) { post '/api/v1/events', params: params }

    describe 'when the event is created by an authorized user' do
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

      it 'it creates a post associated with the user' do
        expect(response.content_type).to eq('application/json')
        expect(response).to have_http_status(:created)
      end
    end

    describe 'Fetchin all events of a club' do
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
      let(:request) { get '/api/v1/events' }

      describe 'when the event is fetched by an authorized user' do
        it 'it creates a post associated with the user' do
          expect(response.content_type).to eq('application/json')
          expect(response).to have_http_status(:ok)
          json_response = JSON.parse(response.body)
          expect(json_response['events'].length).to eq 1
          first_event = json_response['events'][0]
          expect(first_event['evt_type']).to eq 'friendly_match'
          expect(first_event['opponent_id']).to eq opponent.id
          expect(first_event['name']).to eq 'Amazing match'
          expect(first_event['venue']).to eq 'At my place'
        end
      end
    end
  end
end

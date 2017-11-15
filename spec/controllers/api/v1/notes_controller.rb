require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do
  let(:calvin) { create :user }
  let!(:calvin_plans) { create_list :note, 4, user: calvin }
  let!(:other_plans) { create_list :note, 2 }
  let(:response_body) { response.body }
  let(:response_code) { response.response_code }

  describe 'GET index' do
    let(:do_request) { get :index }

    it_behaves_like 'authenticated request'

    describe 'when the user is authenticated' do
      let(:do_request) do
        authenticated_header calvin
        get :index
      end

      let(:expected_response) do
        serialized = ActiveModel::Serializer::CollectionSerializer.new(
          calvin_plans,
          each_serializer: NoteSerializer
        ).as_json
        { notes: serialized }.to_json
      end

      before do
        do_request
      end

      it 'renders the users session plans' do
        expect(response_code).to eq 200
        expect(response_body).to eq expected_response
      end
    end
  end
end

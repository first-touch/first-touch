require 'rails_helper'

RSpec.describe Api::V1::RelationshipsController, type: :controller do
  let(:calvin) { create :user }
  let(:hobbes) { create :user }
  let(:response_body) { JSON.parse response.body }
  let(:response_code) { response.response_code }

  describe 'POST create' do
    let(:do_request) { post :create, followed_id: hobbes.id }

    describe 'when the user is not logged in' do
      it 'does not create a relationship' do
        expect { do_request }.not_to change { Relationship.count }
      end
    end

    describe 'when the user is logged in' do
      before do
        sign_in calvin
      end

      it 'creates the one way relationship' do
        expect { do_request }.to change { Relationship.count }.by 1
        do_request
        expect(response_code).to eq 200
      end
    end
  end

  describe 'DELETE destroy' do
    let!(:relationship) do
      create :relationship,
             follower_id: calvin.id,
             followed_id: hobbes.id
    end

    let(:do_request) { delete :destroy, id: relationship.id }

    describe 'when the user is not logged in' do
      it 'does not destroy the relationship' do
        expect { delete :destroy, id: 1 }.not_to change { Relationship.count }
      end
      it_behaves_like 'authenticated request'
    end

    describe 'when the user is logged in' do
      before do
        sign_in calvin
      end

      it 'creates the one way relationship' do
        expect { do_request }.to change { Relationship.count }.by(-1)
        do_request
        expect(response_code).to eq 200
      end
    end
  end
end

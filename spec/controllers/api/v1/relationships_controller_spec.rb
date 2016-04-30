require 'rails_helper'

RSpec.describe Api::V1::RelationshipsController, type: :controller do

  describe 'POST create' do
    let(:do_request) { post :create }

    describe 'when the user is not logged in' do
      it 'does not create a relationship' do
        expect { post :create }.not_to change { Relationship.count }
      end

      it 'redirects to login url' do
        expect( do_request ).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE destroy' do
    let(:do_request) { delete :destroy, id: 1 }

    describe 'when the user is not logged in' do
      it 'does not create a relationship' do
        expect { delete :destroy, id: 1 }.not_to change { Relationship.count }
      end

      it 'redirects to login url' do
        expect( do_request ).to redirect_to(new_user_session_path)
      end
    end
  end
end

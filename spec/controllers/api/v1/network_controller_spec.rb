require 'rails_helper'

RSpec.describe Api::V1::NetworkController, type: :controller do
  let!(:calvin) { create :user }
  let!(:hobbes) { create :user }
  let!(:susie) { create :user }
  let!(:rosalyn) { create :user }
  let(:response_body) { JSON.parse response.body }
  let(:response_code) { response.response_code }

  before do
    calvin.follow hobbes
    calvin.follow susie
    susie.follow calvin
    rosalyn.follow calvin
    rosalyn.follow susie
  end

  describe 'GET index' do
    let(:do_request) { get :index }

    it_behaves_like 'authenticated request'

    describe 'when the user is authenticated' do
      let(:do_request) do
        authenticated_header calvin
        get :index
      end

      let(:expected_response) do
        network = Api::V1::NetworkController::Network.new({
                                followers: [ susie, rosalyn ],
                                following: [ hobbes, susie ]
                              })
        { network: NetworkSerializer.new(network).as_json }.as_json
      end

      before do
        do_request
      end

      it 'renders the current user network' do
        expect(response_code).to eq 200
        expect(response_body).to eq expected_response
      end
    end
  end

end

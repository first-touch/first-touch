require 'rails_helper'

RSpec.describe Api::V1::VisitorsController, type: :controller do
  describe 'POST pre_register' do
    let(:do_request) { post :pre_register, params: {
                              email: 'hello@mailinator.com',
                              request: 'Amazing spiderman'
                            }}
    let(:response_code) { response.response_code }

    it 'creates a new entry in InterestedPeople' do
      do_request
      expect(response_code).to eq 200
      expect(InterestedPerson.count).to eq 1
    end
  end
end

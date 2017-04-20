RSpec.shared_examples 'authenticated request' do
  describe 'when the user is not authenticated' do
    let(:response_code) { response.response_code }

    before do
      do_request
    end

    it 'renders not authorized' do
      expect(response_code).to eq 401
    end
  end
end

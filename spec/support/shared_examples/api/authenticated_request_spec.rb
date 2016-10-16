RSpec.shared_examples 'authenticated request' do
  describe 'when the user is not authenticated' do
    it 'redirects to login' do
      expect(do_request).to redirect_to(new_user_session_path)
    end
  end
end

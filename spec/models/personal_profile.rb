require 'rails_helper'

RSpec.describe PersonalProfile, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
  end

  describe 'update_search_string' do
    let(:personal_profile) { double(build :personal_profile) }

    it { is_expected.to delegate_method(:update_search_string).to(:user) }
  end
end

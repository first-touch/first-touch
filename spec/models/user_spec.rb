require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_one :personal_profile }
    it { is_expected.to have_many :active_relationships }
    it { is_expected.to have_many(:following).through :active_relationships }
  end

  describe 'follow/unfollow' do
    let(:calvin) { create :user }
    let(:hobes) { create :user }

    it 'allows to follow and unfollow users' do
      expect(calvin.following? hobes).to eq false
      calvin.follow hobes
      expect(calvin.following? hobes).to eq true
      expect(hobes.followers.include? calvin).to eq true
      calvin.unfollow hobes
      expect(calvin.following? hobes).to eq false
    end
  end
end

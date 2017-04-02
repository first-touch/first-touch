require 'rails_helper'

RSpec.describe Club, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:account_owner) }
    it { is_expected.to have_many(:club_users) }
    it { is_expected.to have_many(:users).through(:club_users) }
    it { is_expected.to have_many(:teams) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :city }
    it { is_expected.to validate_presence_of :country_code }
  end
end

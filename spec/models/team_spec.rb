require 'rails_helper'

RSpec.describe Team, type: :model do

  describe 'associations' do
    it { is_expected.to have_many(:users).through(:team_users) }
    it { is_expected.to belong_to(:club) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :team_name }
  end
end

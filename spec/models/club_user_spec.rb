require 'rails_helper'

RSpec.describe ClubUser, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :club }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :club }
    it { is_expected.to validate_presence_of :user }
  end
end

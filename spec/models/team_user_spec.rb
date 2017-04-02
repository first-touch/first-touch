require 'rails_helper'

RSpec.describe TeamUser, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :team }
    it { is_expected.to belong_to :user }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :team }
    it { is_expected.to validate_presence_of :user }
  end
end

require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_one :message_recipient }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :message_body }
    it { is_expected.to validate_presence_of :creator_id }
  end
end

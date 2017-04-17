require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :creator }
    it { is_expected.to have_one :message_recipient }
    it { is_expected.to have_many :images }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :message_body }
    it { is_expected.to validate_presence_of :creator_id }
  end
end

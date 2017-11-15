require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_one :image }
  end

  describe 'validations' do
    before do
      allow(subject).to receive(:process_image)
    end

    it { is_expected.to validate_presence_of :name }
  end
end

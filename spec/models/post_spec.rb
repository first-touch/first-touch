require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to have_many :images }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :content }
  end
end

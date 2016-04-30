require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @relationship = Relationship.new follower_id: 1, followed_id: 2
  end

  it 'is valid' do
    expect(@relationship).to be_valid
  end

  it { is_expected.to validate_presence_of :follower_id }
  it { is_expected.to validate_presence_of :followed_id }

end

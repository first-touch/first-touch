require 'rails_helper'

RSpec.describe User, type: :model do
  let(:calvin) { create :user }
  let(:hobbes) { create :user }

  describe 'associations' do
    it { is_expected.to have_one :personal_profile }
    it { is_expected.to have_many :active_relationships }
    it { is_expected.to have_many(:following).through :active_relationships }
    it { is_expected.to have_many(:posts) }
  end

  describe 'follow/unfollow' do
    it 'allows to follow and unfollow users' do
      expect(calvin.following?(hobbes)).to eq false
      calvin.follow hobbes
      expect(calvin.following?(hobbes)).to eq true
      expect(hobbes.followers.include?(calvin)).to eq true
      calvin.unfollow hobbes
      expect(calvin.following?(hobbes)).to eq false
    end
  end

  describe 'feed' do
    let(:post_content) { 'This is my test' }
    let!(:post_hobbes) { create :post, content: post_content, user: hobbes }
    let!(:post_calvin) { create :post, content: post_content, user: calvin }

    before do
      calvin.follow hobbes
    end

    it 'returns the of the users that current user follows' do
      expect(calvin.feed).to eq [post_calvin, post_hobbes]
      expect(hobbes.feed).to eq [post_hobbes]
    end
  end

  describe 'inbox' do
    let(:susie) { create :user }
    let(:message_c_h_one) { create :message, creator_id: calvin.id }
    let!(:message_recipient_c_h_one) do
      create :message_recipient,
             message: message_c_h_one,
             recipient_id: hobbes.id
    end

    let(:message_h_c_one) { create :message, creator_id: hobbes.id }
    let!(:message_recipient_h_c_one) do
      create :message_recipient,
             message: message_h_c_one,
             recipient_id: calvin.id
    end

    let(:message_c_h_two) { create :message, creator_id: calvin.id }
    let!(:message_recipient_c_h_two) do
      create :message_recipient,
             message: message_c_h_two,
             recipient_id: hobbes.id
    end

    let(:message_c_h_three) { create :message, creator_id: calvin.id }
    let!(:message_recipient_c_h_three) do
      create :message_recipient,
             message: message_c_h_three,
             recipient_id: hobbes.id
    end

    let(:message_h_c_two) { create :message, creator_id: hobbes.id }
    let!(:message_recipient_h_c_two) do
      create :message_recipient,
             message: message_h_c_two,
             recipient_id: calvin.id
    end

    it 'returns the messages in the right order' do
      expect(calvin.inbox).to eq(hobbes.id => [message_c_h_one,
                                               message_h_c_one,
                                               message_c_h_two,
                                               message_c_h_three,
                                               message_h_c_two])
    end
  end
end

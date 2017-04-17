require 'rails_helper'

RSpec.describe Image, type: :model do
  let(:image) { build :image }

  describe 'associations' do
    it { is_expected.to belong_to :imageable }
    it { is_expected.to have_attached_file(:file) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:imageable) }
    it { is_expected.to validate_attachment_presence(:file) }
    it { is_expected.to validate_attachment_content_type(:file).
      allowing('image/png', 'image/gif', 'image/jpeg', 'image/jpg', 'image/x-ms-bmp').
      rejecting('text/plain', 'text/xml')
    }
  end

  describe '#url' do
    it "returns its file's default url" do
      expect(image.url).to eq image.file.url
    end
  end

  describe '#medium_url' do
    it "returns its file's medium url" do
      expect(image.medium_url).to eq image.file.url(:medium)
    end
  end

  describe '#thumbnail_url' do
    it "returns its file's thumb url" do
      expect(image.thumbnail_url).to eq image.file.url(:thumb)
    end
  end

end

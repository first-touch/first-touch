require 'rails_helper'

RSpec.describe Users::PublicProfileSerializer, type: :serializer do
  let(:model) { create :user, :with_personal_profile }
  let(:subject) { described_class.new model, following: true }

  it 'matches the correct json schema' do
    expect(subject.as_json).to match_json_schema 'users/public_profile'
  end
end

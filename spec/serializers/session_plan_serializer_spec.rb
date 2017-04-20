require 'rails_helper'

RSpec.describe SessionPlanSerializer, type: :serializer do
  let(:model) { create :session_plan }
  let(:subject) { described_class.new model }

  it 'matches the correct json schema' do
    expect(subject.as_json).to match_json_schema 'session_plan'
  end
end

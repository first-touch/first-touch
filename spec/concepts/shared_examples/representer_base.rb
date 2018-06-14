require 'rails_helper'

shared_examples_for 'json representer' do
  let(:representer) { representer_class.new(model) }

  it 'matches the json schema' do
    expect(representer.as_json).to match_json_schema expected_schema
  end
end

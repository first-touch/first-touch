require 'sidekiq/testing'
require 'rails_helper'

describe Importer::Roster do
  let(:success) { double(success?: true) }

  before do
    allow(::V1::Roster::Import).to receive(:call).and_return success
  end

  it 'calls roster import operation with the right params' do
    Importer::Roster.new.perform('filename', 10)
    expect(::V1::Roster::Import).to have_received(:call).with(
      params: { roster_file: 'filename', club_id: 10 }
    )
  end
end

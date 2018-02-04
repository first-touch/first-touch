require 'rails_helper'
require 'sidekiq/testing'

describe Statistics::TrackRequest do
  describe 'when all the arguments are correct' do
    let(:params) do
      [
        Statistic::PROFILE_VIEW,
        {
          requested_profile_id: 1,
          requested_profile_type: 'club',
          requested_by_id: 1,
          requested_by_type: 'user',
          requested_date: '02/02/2018 10:08:00'
        }
      ]
    end

    it 'stores the statistic record' do
      expect(Statistic.count).to eq 0
      Statistics::TrackRequest.new.perform(*params)
      expect(Statistic.count).to eq 1
      first_record = Statistic.first
      expect(first_record.stat_type).to eq Statistic::PROFILE_VIEW
      expect(first_record.metadata).to eq params[1].with_indifferent_access
    end
  end
end

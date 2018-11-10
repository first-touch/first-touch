require 'rails_helper'

describe V1::Report::Create do
  let(:current_user) do
    create :user
  end

  let(:report_good) do
    res = V1::Report::Create.(
      params: {
        headline: 'The new ronaldo',
        price: 20,
        type_report: report_name,
        status: 'publish'
      },
      current_user: current_user
    )
    res[:model]
  end

  let(:report_failed) do
    res = V1::Report::Create.(params: {},
      current_user: current_user
    )
    res[:model]
  end

  describe 'when report is invalid' do
    it 'fails to register the report' do
      expect(report_failed).to_not be_persisted
    end
  end

  describe 'when report is valid' do
    let(:report_name) { 'player' }

    it 'succeed to register the report' do
      res = V1::Report::Create.(
        params: {
          headline: 'The new ronaldo',
          price: 20,
          type_report: report_name
        },
        current_user: current_user
      )
      expect(report_good).to be_persisted
    end
  end

  describe 'when report is wrong type' do
    let(:report_name) { 'basketplayer' }
    it 'fails to register the report' do
      expect(report_good).to_not be_persisted
    end
  end
end

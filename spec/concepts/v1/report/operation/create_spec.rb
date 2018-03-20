require 'rails_helper'

describe V1::Report::Create do
  let(:current_user) do
    create :user
  end

  let(:reportGood) do
    res = V1::Report::Create.(
      {
        user: current_user,
        headline: 'The new ronaldo',
        price: 20,
        type_report: report_name
      }
    )
    res['model']
  end

  let(:reportFailed) do
    res = V1::Report::Create.(
      {
        user: current_user
      }
    )
    res['model']
  end

  describe 'when report is invalid' do
    it 'fails to register the report' do
      expect(reportFailed).to_not be_persisted
    end
  end

  describe 'when report is valid' do
    let(:report_name) { 'player' }

    it 'succeed to register the report' do
      res = V1::Report::Create.(
        {
          user: current_user,
          headline: 'The new ronaldo',
          price: 20,
          type_report: report_name
        }
      )
      expect(reportGood).to be_persisted
    end
  end

  describe 'when report is wrong type' do
    let(:report_name) { 'basketplayer' }
    it 'fails to register the report' do
      expect(reportGood).to_not be_persisted
    end
  end
end

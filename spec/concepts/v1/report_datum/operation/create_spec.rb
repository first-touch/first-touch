require 'rails_helper'

describe V1::ReportDatum::Create do
  let(:current_user) do
    create :user
  end

  let(:current_report) do
    create :report
  end

  let(:report_datum) do
    res = V1::ReportDatum::Create.(
      {
        report: current_report,
        meta_data:"Is the worst"
      }
    )
    res['model']
  end

  describe 'when report_datum is persisted' do
    it 'persists the event' do
      expect(report_datum).to be_persisted
      expect(report_datum.last_version).to be true
    end
  end

  describe 'when creating a new version of report' do

    let(:new_version) do
      new_version = V1::ReportDatum::Create.(
        {
          meta_data: 'Is the worst',
          report: current_report
        }
      )['model']
    end

    it 'will create a new version of the report' do
      expect(report_datum.version).to eq(1)
      expect(new_version.version).to eq(report_datum.version + 1)
      report_datum.reload
      expect(report_datum.last_version).to be false
      expect(new_version.last_version).to be true
    end
  end
end
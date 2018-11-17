require 'rails_helper'

describe V1::Report::Create do
  let(:current_user) do
    res = V1::User::Register.(
      params: {
        email: 'test@banaas.com',
        password: '123123',
        password_confirmation: '123123',
        role_name: 'scout',
        personal_profile: {
          first_name: 'Test',
          last_name: 'Bananas',
          birthday: '10/01/1989'
        }
      }
    )
    res[:model]
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
    let(:report_type) { 'player' }
    let(:report_status) { 'pending' }
    let(:meta_data) do
      {
        "player_info": {
          "nationality_country_code": "123",
          "residence_country_code": "123"
        }
      }
    end

    let(:successful_report) do
      res = V1::Report::Create.(
        params: {
          user: current_user,
          headline: 'The new ronaldo',
          price: 20,
          status: report_status,
          type_report: report_type,
          meta_data: meta_data
        },
        current_user: current_user
      )
      res[:model]
    end

    it 'succeed to register the report' do
      expect(successful_report).to be_persisted
    end
  end

  describe 'when report is wrong type' do
    let(:report_name) { 'basketplayer' }
    it 'fails to register the report' do
      expect(report_good).to_not be_persisted
    end
  end
end

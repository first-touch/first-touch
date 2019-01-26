require 'rails_helper'

RSpec.describe V1::Club::Create do
  let(:user) do
    res = V1::User::Register.(
      params: {
        email: 'test@banaas.com',
        password: '123123',
        role_name: 'director',
        password_confirmation: '123123',
        personal_profile: {
          first_name: 'Test',
          last_name: 'Bananas',
          birthday: '10/01/1989'
        }
      }
    )
    res[:model]
  end
  let(:params) do
    {
      name: 'Club',
      country_code: 'PT',
      account_owner_id: user.id
    }
  end
  let(:operation) { V1::Club::Create.(params: params) }

  describe 'when there are no missing params' do
    it 'persist the club' do
      expect(operation.success?).to eq true
      club = operation[:model]
      expect(club).to be_persisted
      expect(club.account_owner).to eq user
      expect(club.country_code).to eq 'PT'
      expect(club.name).to eq 'Club'
    end
  end

  describe 'when there are missing params' do
    describe 'when account owner is missing' do
      let(:params) { { name: 'Club', country_code: 'PT', account_owner_id: nil } }

      it 'would not persist the club' do
        expect(operation.failure?).to eq true
        expect(operation.errors).to include ["can't be blank"]
      end
    end

    describe 'when name is missing' do
      let(:params) { { name: nil, country_code: 'PT', account_owner_id: user.id } }

      it 'would not persist the club' do
        expect(operation.failure?).to eq true
        expect(operation.errors).to include ["can't be blank"]
      end
    end

    describe 'when country code is missing' do
      let(:params) { { name: 'Club', country_code: nil, account_owner_id: user.id } }

      it 'would not persist the club' do
        expect(operation.failure?).to eq true
        expect(operation.errors).to include ["can't be blank"]
      end
    end
  end
end

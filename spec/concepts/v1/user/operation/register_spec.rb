require 'rails_helper'

RSpec.describe V1::User::Register do
  let(:owner) do
    res = V1::User::Register.(
      params: {
        email: 'test1@firsttouch.io',
        password: 'password',
        password_confirmation: 'password',
        role_name: role_name,
        personal_profile: {
          first_name: 'What',
          last_name: 'Bananas',
          birthday: '10/01/1999'
        }
      }
    )
    res[:model]
  end

  let!(:existing_club) do
    res = V1::Club::Create.(
      params: {
        account_owner_id: owner.id,
        name: 'Club',
        city: 'City',
        country_code: 'PT',
      }
    )
    res[:model]
  end
  let(:params) do
    {
      email: 'test@firsttouch.io',
      password: 'password',
      password_confirmation: 'password',
      role_name: role_name,
      club_id: existing_club.id,
      personal_profile: {
        first_name: 'Test',
        last_name: 'Bananas',
        birthday: '10/01/1990'
      }
    }
  end
  let(:operation) { V1::User::Register.(params: params) }

  shared_examples 'registerable role' do |role_name|
    it 'registers the user' do
      expect(operation.success?).to eq true
      user = operation[:model]
      expect(user).to be_persisted
      expect(user.roles.first).to eq Role.find_by(name: role_name)
    end
  end

  FirstTouch::REGISTERABLE_ROLE_NAMES.each do |role_name|
    describe "registering user as a #{role_name}" do
      let(:role_name) { role_name }
      it_behaves_like 'registerable role', role_name
    end
  end

  describe 'registering user with a club' do
    let(:role_name) { 'scout' }
    it 'associates the user with the club' do
      expect(operation.success?).to eq true
      user = operation[:model]
      expect(user).to be_persisted
      expect(user.clubs.first).to eq existing_club
    end
  end

  describe 'when role is invalid' do
    let(:role_name) { 'admin' }
    it 'fails to register the user' do
      expect(operation.success?).to eq false
      user = operation[:model]
      expect(user).to_not be_persisted
    end
  end
end

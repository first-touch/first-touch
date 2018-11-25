require 'rails_helper'

RSpec.describe V1::Club::Update do
  let!(:banana_user) do
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
  let!(:apple_user) do
    res = V1::User::Register.(
      params: {
        email: 'googoo@apple.com',
        password: '123123',
        role_name: 'director',
        password_confirmation: '123123',
        personal_profile: {
          first_name: 'googoo',
          last_name: 'apple',
          birthday: '10/01/1988'
        }
      }
    )
    res[:model]
  end
  let!(:existing_club) do
    res = V1::Club::Create.(
      params: {
        name: 'Club',
        country_code: 'PT',
        account_owner_id: banana_user.id
      }
    )
    res[:model]
  end
  let(:params) do
    {
      id: existing_club.id,
      "user_id" => apple_user.id,
      name: 'Not Club',
      country_code: 'ID'
    }
  end
  let(:operation) { V1::Club::Update.(params: params) }

  describe 'when there are no missing params' do
    it 'updates the attributes of the club' do
      expect(operation.success?).to eq true
      club = operation[:model]
      expect(club.account_owner).to eq apple_user
      expect(club.name).to eq 'Not Club'
      expect(club.country_code).to eq 'ID'
    end
  end
end

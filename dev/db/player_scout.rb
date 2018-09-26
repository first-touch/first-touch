





result = ::V1::User::Register.(email: 'dpayet@ftouch.io', password: '123456789', password_confirmation: "123456789", role_name: 'player', personal_profile: {
  first_name: 'Dimitri',
  last_name: 'Payet',
  nationality_country_code: 'FR',
  residence_country_code: 'FR',
  weight: 70,
  height: 180,
  preferred_foot: 'R',
  playing_position: 'striker',
  pro_status: 'N/A',
  birthday: '1980-05-10'
})
team = ::Team.find(3)
user = ::User.find_by(email: 'dpayet@ftouch.io')
user.teams = [team]
club = ::Club.find(5129)
user.clubs = [club]
user.save!

result = ::V1::User::Register.(email: 'minoraiola@ftouch.io', password: '123456789', password_confirmation: "123456789", role_name: 'scout', personal_profile: {
  first_name: 'Mino',
  last_name: 'Raiola',
  birthday: '1970-05-10'
})

class Users::SearchSerializer < UserSerializer
  attributes :id, :display_name

  def display_name
    [personal_profile.first_name, personal_profile.middle_name, personal_profile.last_name].join ' '
  end
end

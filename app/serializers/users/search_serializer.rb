class Users::SearchSerializer < UserSerializer
  attributes :id, :display_name

  def display_name
    name = [object.first_name, object.middle_name, object.last_name]
             .join(' ')
             .squish
    name = object.email_local_part if name.empty?
    name
  end
end

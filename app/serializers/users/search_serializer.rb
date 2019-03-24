class Users::SearchSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :display_name, :avatar_url, :role_name

  def display_name
    name = [object.first_name, object.middle_name, object.last_name]
           .join(' ')
           .squish
    name = object.email_local_part if name.empty?
    name
  end

  def avatar_url
    if object.personal_profile.avatar.attached?
      rails_blob_path(object.personal_profile.avatar)
    else
      FirstTouch::AVATAR
    end
  end

  def role_name
    object.roles.first.name
  end
end

module V1
  module User
    module Representer
      class Search < Representable::Decorator
        include Rails.application.routes.url_helpers
        include Representable::JSON

        property :id
        property :display_name
        property :avatar_url, exec_context: :decorator
        property :role_name, exec_context: :decorator

        def avatar_url
          if represented.personal_profile.avatar.attached?
            rails_blob_path(represented.personal_profile.avatar)
          else
            FirstTouch::AVATAR
          end
        end

        def role_name
          represented.roles.first.name
        end
      end
    end
  end
end

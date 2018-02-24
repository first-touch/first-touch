module V1
  module User
    module Representer
      class PublicProfile < Representable::Decorator
        include Representable::JSON

        property :id
        property :following
        property :personal_profile,
                 extend: V1::PersonalProfile::Representer::Simplified

        property :following
        property :connection_status
        property :role_name, exec_context: :decorator

        def role_name
          represented.roles.first.name
        end
      end
    end
  end
end

module V1
  module User
    module Representer
      class SelfProfile < Representable::Decorator
        include Representable::JSON

        property :id
        property :career_history
        property :personal_profile,
                 extend: V1::PersonalProfile::Representer::Simplified

        property :role_name, exec_context: :decorator

        def role_name
          represented.roles.first.name
        end
      end

      class PublicProfile < SelfProfile
        property :following
        property :connection_status
      end
    end
  end
end

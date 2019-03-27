module V1
  module Network
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON
        property :id, exec_context: :decorator
        property :display_name, exec_context: :decorator
        property :avatar_url, exec_context: :decorator
        property :role_name, exec_context: :decorator

        def display_name
          represented.connected_to.display_name
        end

        def id
          represented.connected_to.id
        end

        def avatar_url
          represented.connected_to.personal_profile.avatar_url
        end

        def role_name
          represented.connected_to.roles[0].name
        end
        # property :connected_to, decorator: ::V1::User::Representer::Search
      end

      class Index < Representable::Decorator
        include Representable::JSON
        collection :to_a, as: :network, decorator: Full
      end
    end
  end
end

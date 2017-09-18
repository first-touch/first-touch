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
      end
    end
  end
end

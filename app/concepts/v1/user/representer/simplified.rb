module V1
  module User
    module Representer
      class Simplified < Representable::Decorator
        include Representable::JSON

        property :id
        property :personal_profile,
                 extend: V1::PersonalProfile::Representer::Simplified
      end
    end
  end
end

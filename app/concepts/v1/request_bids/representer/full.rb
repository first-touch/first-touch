module V1
  module RequestBid
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :status
        property :user, getter: lambda { |represented:, **|
          ::V1::PersonalProfile::Representer::Simplified.new(
            represented.user.personal_profile
          )
        }
        property :price
        property :request
        property :created_at
      end
    end
  end
end

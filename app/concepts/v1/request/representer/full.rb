module V1
  module Request
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :user, getter:  -> (represented:, **) {
          ::V1::PersonalProfile::Representer::Simplified.new(represented.user.personal_profile)
        }
        property :meta_data
        property :min_price
        property :max_price
        property :type_request
        property :status
        property :deadline
        property :created_at

      end
    end
  end
end

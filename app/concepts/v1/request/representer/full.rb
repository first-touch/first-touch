module V1
  module Request
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :club
        property :player, decorator: ::V1::User::Representer::Simplified
        property :team, decorator: ::V1::Team::Representer::Simplified
        property :league, decorator: ::V1::Competition::Representer::Simplified
        property :meta_data
        property :price
        property :type_request
        property :status
        property :deadline
        property :created_at
        collection :request_bids
      end
    end
  end
end

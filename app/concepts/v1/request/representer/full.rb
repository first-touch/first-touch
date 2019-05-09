module V1
  module Request
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :club
        property :player, representer: ::V1::User::Representer::PublicProfile
        property :team, representer: ::V1::Team::Representer::Simplified
        property :league, representer: ::V1::Competition::Representer::Simplified
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

module V1
  module Request
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :club
        property :player, representer: ::V1::User::Representer::PublicProfile

        property :team, getter: lambda { |represented:, **|
          if represented.team
            ::V1::Team::Representer::Simplified.new(
              represented.team
            )
          end
        }

        property :league, getter: lambda { |represented:, **|
          if represented.league
            ::V1::Competition::Representer::Simplified.new(
              represented.league
            )
          end
        }

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

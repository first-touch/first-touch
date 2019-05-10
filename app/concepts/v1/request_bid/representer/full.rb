module V1
  module RequestBid
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :status
        property :user, representer: ::V1::User::Representer::PublicProfile
        property :request, representer: ::V1::Request::Representer::Full
        property :price
        property :created_at
      end
    end
  end
end

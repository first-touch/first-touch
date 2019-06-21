module V1
  module RequestBid
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :status
        property :user, decorator: ::V1::User::Representer::Simplified
        property :request, decorator: ::V1::Request::Representer::Full
        property :price
        property :created_at
      end
    end
  end
end

module V1
  module Event
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :evt_type
        property :organizer_id
        property :opponent_id
        property :name
        property :description
        property :venue
        property :start_date
        property :end_date
      end
    end
  end
end

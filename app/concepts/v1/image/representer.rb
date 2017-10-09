module V1
  module Image
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :thumbnail_url
        property :url
      end
    end
  end
end

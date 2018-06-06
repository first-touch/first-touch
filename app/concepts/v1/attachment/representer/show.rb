module V1
  module Attachment
    module Representer
      class ShowFull < Representable::Decorator
        include Representable::JSON
        property :id
        property :filename
        property :url
      end

      class Show < Representable::Decorator
        include Representable::JSON
        property :filename
      end
    end
  end
end

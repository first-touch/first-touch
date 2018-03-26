module V1
  module Attachment
    module Representer
      class Resume < Representable::Decorator
        include Representable::JSON
        property :id
        property :filename
      end
    end
  end
end
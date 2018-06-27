module V1
  module Attachment
    module Representer
      class Index < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :attachments, decorator: Show
      end

      class IndexFull < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :attachments, decorator: ShowFull
      end
    end
  end
end

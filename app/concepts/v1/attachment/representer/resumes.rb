module V1
  module Attachment
    module Representer
      class Resumes < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :attachments, decorator: Resume

      end
    end
  end
end
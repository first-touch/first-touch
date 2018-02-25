module V1
  module DirectUpload
    module Representer
      class SignedUrl < Representable::Decorator
        include Representable::JSON

        property :presigned_url
        property :public_url
      end
    end
  end
end
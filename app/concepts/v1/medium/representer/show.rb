module V1
  module Medium
    module Representer
      class Show < Representable::Decorator
        include Representable::JSON
        include Rails.application.routes.url_helpers

        property :id
        property :url, exec_context: :decorator

        def url
          rails_blob_path(represented)
        end
      end
    end
  end
end

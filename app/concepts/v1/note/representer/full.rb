module V1
  module Note
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :user_id
        property :name
        property :content
        property :image_url
        property :tags, exec_context: :decorator

        def tags
          represented.tags.pluck(:name)
        end
      end
    end
  end
end

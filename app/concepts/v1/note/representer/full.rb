module V1
  module Note
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :author, exec_context: :decorator
        property :name
        property :content
        property :image_url
        property :tags, exec_context: :decorator
        property :updated_at

        def tags
          represented.tags.pluck(:name)
        end

        def author
          represented.user.display_name
        end
      end
    end
  end
end

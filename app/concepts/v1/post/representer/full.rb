module V1
  module Post
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :content
        property :author_id
        property :author_name, exec_context: :decorator
        property :author_status, exec_context: :decorator
        property :created_at
        property :updated_at
        collection :images, extend: V1::Image::Representer::Full

        def author_name
          represented.author.display_name
        end

        def author_status
          represented.author.roles.first.name
        end
      end

      class Index < Representable::Decorator
        include Representable::JSON

        collection :to_a, as: :posts, decorator: Full
      end
    end
  end
end

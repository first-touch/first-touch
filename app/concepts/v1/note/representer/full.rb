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
        collection :all_tags_list, as: :tags
      end
    end
  end
end

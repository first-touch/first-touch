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
        collection :all_tags_list, as: :tags # need to clean up collection to prevent multiple queries
      end
    end
  end
end

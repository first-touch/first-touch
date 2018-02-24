module V1
  module Note
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :user_id
        property :name
        property :content
        property :image, extend: V1::Image::Representer::Full
        collection :all_tags_list
        #collection :labels
      end
    end
  end
end

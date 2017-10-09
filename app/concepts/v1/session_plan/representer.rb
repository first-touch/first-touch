module V1
  module SessionPlan
    module Representer
      class Full < Representable::Decorator
        include Representable::JSON

        property :id
        property :user_id
        property :name
        property :image, extend: V1::Image::Representer::Full
        collection :tags
      end
    end
  end
end

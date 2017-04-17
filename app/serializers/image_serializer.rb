class ImageSerializer < ActiveModel::Serializer
  attributes :url,
             :thumbnail_url,
             :id
end

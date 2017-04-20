class SessionPlanSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :tags
  has_one :image, serializer: ImageSerializer
end

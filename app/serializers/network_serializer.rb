class NetworkSerializer < ActiveModel::Serializer
  has_many :followers, serializer: Users::SearchSerializer
  has_many :following, serializer: Users::SearchSerializer
end

class NetworkSerializer < ActiveModel::Serializer
  has_many :followers, each_serializer: Users::SearchSerializer
  has_many :following, each_serializer: Users::SearchSerializer
end

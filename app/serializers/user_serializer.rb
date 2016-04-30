class UserSerializer < ActiveModel::Serializer
  attributes :id
  has_one :personal_profile
end

class UserSerializer < ActiveModel::Serializer
  attributes :id, :career_history
  has_one :personal_profile

  def career_history
    ActiveModel::Serializer::CollectionSerializer.new(object.career_history, each_serializer: CareerEntrySerializer)
  end
end

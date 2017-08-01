class Users::PublicProfileSerializer < ActiveModel::Serializer
  attributes :id, :following
  has_one :personal_profile

  def following
    instance_options[:following] || false
  end
end

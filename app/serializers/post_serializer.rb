class PostSerializer < ActiveModel::Serializer
  attributes :id,
             :content,
             :author_id,
             :author_name,
             :author_status,
             :created_at,
             :updated_at

  has_many :images, serializer: ImageSerializer

  def author_id
    object.user_id
  end

  def author_name
    object.user.full_name
  end

  def author_status
    "Football Player at F.C. Porto"
  end
end

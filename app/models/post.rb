class Post < ApplicationRecord
  belongs_to :author, polymorphic: true
  belongs_to :user,
             -> { where(posts: { author_type: 'User' }) },
             foreign_key: 'author_id'

  belongs_to :club,
             -> { where(posts: { author_type: 'Club' }) },
             foreign_key: 'author_id'

  validates_presence_of :content
end

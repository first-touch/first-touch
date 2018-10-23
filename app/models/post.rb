class Post < ApplicationRecord
  belongs_to :author, polymorphic: true
  # belongs_to :user,
  #            -> { where(posts: { author_type: 'User' }) },
  #            foreign_key: 'author_id'

  # belongs_to :club,
  #            -> { where(posts: { author_type: 'Club' }) },
  #            foreign_key: 'author_id'

  has_many :images, as: :imageable, inverse_of: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images,
                                allow_destroy: true,
                                reject_if: lambda { |attr|
                                  attr['id'].blank? && attr['file'].blank?
                                }

  validates_presence_of :content
end

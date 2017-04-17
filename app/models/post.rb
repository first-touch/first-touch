class Post < ApplicationRecord
  belongs_to :user
  has_many :images, as: :imageable, inverse_of: :imageable, dependent: :destroy

  accepts_nested_attributes_for :images,
                                allow_destroy: true,
                                reject_if: lambda { |attr|
                                  attr['id'].blank? && attr['file'].blank?
                                }

  validates_presence_of :content
end

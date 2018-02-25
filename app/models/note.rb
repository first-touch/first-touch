class Note < ApplicationRecord

  acts_as_taggable

  belongs_to :user
  validates_presence_of :name
  enum field_type: [:full, :half]

end

class Note < ApplicationRecord
  before_validation :process_image

  belongs_to :user
  has_one :image, as: :imageable, inverse_of: :imageable, dependent: :destroy

  accepts_nested_attributes_for :image

  validates_presence_of :name

  def process_image
    return if image.nil?
    image.file_file_name = "#{name}.jpg"
  end
end

class Image < ApplicationRecord
  belongs_to :imageable, polymorphic: true, touch: true
  validates_presence_of :imageable

  has_attached_file :file,
                    styles: {
                      thumb: '100x100\>',
                      medium: '300x300\>',
                      resized: '600x600\>'
                    },
                    default_style: :resized,
                    s3_protocol: 'https'

  validates_attachment_content_type :file, content_type: [
    'image/jpg',
    'image/jpeg',
    'image/bmp',
    'image/png',
    'image/gif',
    'image/x-ms-bmp'
  ]
  validates_attachment_presence :file

  def url
    file.url
  end

  def medium_url
    file.url(:medium)
  end

  def thumbnail_url
    file.url(:thumb)
  end
end

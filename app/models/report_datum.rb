class ReportDatum < ApplicationRecord
  belongs_to :report
  has_many :attachment_items
  has_many :attachments, through: :attachment_items

  validates_presence_of :meta_data
  validates_presence_of :report
end

class Attachment < ApplicationRecord
  has_many :attachment_items,
            dependent: :destroy

  has_many :report_data, through: :attachment_items, source: :report_datum
end

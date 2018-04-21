class AttachmentItem < ApplicationRecord
  belongs_to :attachment
  belongs_to :report_datum
end

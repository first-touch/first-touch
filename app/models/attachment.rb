class Attachment < ApplicationRecord
  belongs_to :report, optional: true
  belongs_to :request_bid, optional: true
end

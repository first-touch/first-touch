class ReportDatum < ApplicationRecord
  belongs_to :report

  validates_presence_of :meta_data
  validates_presence_of :report

end

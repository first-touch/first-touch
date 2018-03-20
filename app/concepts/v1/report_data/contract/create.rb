module V1
  module ReportDatum
    module Contract
      class Create < Reform::Form
        property :report
        property :meta_data
        validates :report, :meta_data, presence: true
      end
    end
  end
end
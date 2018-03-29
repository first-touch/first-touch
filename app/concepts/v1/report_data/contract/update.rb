module V1
  module ReportDatum
    module Contract
      class Update < Reform::Form
        property :meta_data
        validates :meta_data, presence: true
      end
    end
  end
end
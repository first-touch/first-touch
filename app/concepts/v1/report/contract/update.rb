module V1
  module Report
    module Contract
      class Update < Reform::Form
        property :headline
        property :status
        property :price
        property :meta_data

        validates_with ::Report::ReportOfRequestValidator
      end
    end
  end
end

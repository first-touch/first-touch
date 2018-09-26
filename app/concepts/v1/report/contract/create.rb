module V1
  module Report
    module Contract
      class Create < Reform::Form
        property :user
        property :headline
        property :status
        property :type_report
        property :price
        property :team_id
        property :player_id
        property :meta_data
        validates :status,
                  inclusion: {
                    in: FirstTouch::REGISTERABLE_REPORT_STATUS,
                    message: 'is not available for this report'
                  }
        validates :type_report,
                  inclusion: {
                    in: FirstTouch::REGISTERABLE_REPORT_TYPES,
                    message: 'is not available for this report'
                  }
        validates :headline, :user, :status, :price, :type_report, presence: true
      end
    end
  end
end

module V1
  module Report
    module Contract
      class Pending < Reform::Form
        property :user
        property :type_report
        property :request_id
        property :status
        property :price
        property :completion_status
        validates :user, :type_report, :request_id, :completion_status, :status, :price, presence: true
      end
    end
  end
end

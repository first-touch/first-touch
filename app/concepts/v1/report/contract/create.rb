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

        validates :headline, :user, :price, :type_report, :meta_data, presence: true
      end
    end
  end
end

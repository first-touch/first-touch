module V1
  module Report
    module Contract
      class Create < Reform::Form
        property :user
        property :headline
        property :status
        property :type_report
        property :price
        property :club_id
        property :player_id
        property :meta_data

        validates :headline, :user, :price, :type_report, presence: true
      end
    end
  end
end

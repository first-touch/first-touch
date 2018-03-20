module V1
  module Report
    module Contract
      class Create < Reform::Form
        property :user
        property :headline
        property :index
        property :type_report
        property :version
        property :price
        property :club_id
        property :player

        validates :headline, :user, :price,:type_report, presence: true
      end
    end
  end
end
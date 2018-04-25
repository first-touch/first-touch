module V1
  module Request
    module Contract
      class Create < Reform::Form
        property :price
        property :meta_data
        property :deadline
        property :type_request
        property :status
        validates :status, :meta_data, :deadline, :price,
                  :type_request, presence: true
      end
    end
  end
end

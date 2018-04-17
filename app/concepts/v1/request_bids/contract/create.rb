module V1
  module Request
    module Contract
      class Create < Reform::Form
        property :min_price
        property :max_price
        property :meta_data
        property :deadline
        property :type_request
        property :status
        validates :min_price, :status, :meta_data, :deadline,
                  :type_request, presence: true
      end
    end
  end
end

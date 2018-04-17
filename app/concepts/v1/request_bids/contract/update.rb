module V1
  module Request
    module Contract
      class Update < Reform::Form
        property :min_price
        property :max_price
        property :meta_data
        property :deadline
        property :status
      end
    end
  end
end

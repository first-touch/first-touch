module V1
  module RequestBid
    module Contract
      class Update < Reform::Form
        property :price
        property :status
      end
    end
  end
end

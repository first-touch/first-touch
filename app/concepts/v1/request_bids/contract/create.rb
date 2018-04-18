module V1
  module RequestBids
    module Contract
      class Create < Reform::Form
      property :price
      property :status
      property :request

      validates :price, presence: true  do
        false
        puts price
      end

      end
    end
  end
end

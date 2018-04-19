module V1
  module RequestBids
    module Contract
      class Create < Reform::Form
      property :price
      property :status
      property :request

      validates :price, presence: true

      validates_uniqueness_of :request, scope: %i[request user]

      end
    end
  end
end

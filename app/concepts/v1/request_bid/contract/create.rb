module V1
  module RequestBid
    module Contract
      class Create < Reform::Form
        property :price
        property :status
        property :request

        validates :request, presence: true
        validate :price do
          if (price['value'].to_i < request.price['value'].to_i) || (price['value'].to_i > request.price['max'].to_i)
            errors.add(:price, 'bid.price_range')
          end
        end
      end
    end
  end
end

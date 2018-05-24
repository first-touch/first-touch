module V1
  module RequestBid
    module Contract
      class Create < Reform::Form
        property :price
        property :status
        property :request

        validate :price do
          # TODO: this validation will be review once currency is add to bid price
          if request.type_request != 'position'
            if (price['value'].to_i < request.price['value'].to_i) || (price['value'].to_i > request.price['max'].to_i)
              errors.add(:price, 'bid.price_range')
            end
          end
        end
      end
    end
  end
end

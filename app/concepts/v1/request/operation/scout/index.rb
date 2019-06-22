module V1
  module Request
    module Operation
      module Scout
        class Index < FirstTouch::Operation
          step :find_models!

          private

          def find_models!(options, current_user:, **)
            requests_with_bids = ::RequestBid.where(user_id: current_user.id)
                                             .where.not(status: 'cancelled')
                                             .pluck :request_id
            options[:models] = ::Request.where.not(id: requests_with_bids)
          end
        end
      end
    end
  end
end

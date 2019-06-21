module V1
  module Request
    module Operation
      module Scout
        class Index < FirstTouch::Operation
          step :find_models!

          private

          def find_models!(options, current_user:, **)
            options[:models] = ::Request
                               .joins('LEFT JOIN request_bids ON requests.id = request_bids.request_id')
                               .where(request_bids: { request_id: nil })
                               .or(
                                 ::Request.joins('LEFT JOIN request_bids ON requests.id = request_bids.request_id')
                                          .where.not(request_bids: { user_id: current_user.id })
                               )
          end
        end
      end
    end
  end
end

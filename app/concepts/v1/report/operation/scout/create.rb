module V1
  module Report
    module Operation
      module Scout
        class Create < FirstTouch::Operation
          step Model(::Report, :new)
          # TODO: Associate with a request_bid if there is one
          # step :find_request_bid!
          # failure :invalid_associated_request_bid, fail_fast: true

          private

          def find_models!(options, current_user:, **)
            options[:models] = ::Report.where(user_id: current_user.id)
          end

          def find_request_bid!(_opts, params:, current_user:, model:, **)
            return true unless params['report']['request_bid_id']

            request_bid_id = params['report']['request_bid_id']
            model.request_bid = current_user.request_bids.find_by(id: request_bid_id)
            !model.request_bid.nil?
          end
        end
      end
    end
  end
end

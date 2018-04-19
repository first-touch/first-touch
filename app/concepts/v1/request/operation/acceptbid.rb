module V1
  module Request
    class AcceptBid < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :payment
      failure :process_payment_failure!, fail_fast: true
      step :order
      step :finalize
      step Trailblazer::Operation::Contract::Build(
        constant: RequestBids::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      private

      def find_model!(options,  params:, current_user:, **)
        requestId = params[:request_id]
        bidId = params[:bid_id]
        request = nil
        model = nil
        if current_user.is_a?(::Club) || true
          request = current_user.requests.find(requestId)
          model = request.request_bids.find_by(id: bidId, status: 'pending')
          if model
            params['currency'] = request.price['currency']
          end
        end
        options['model'] = model
        options['model.class'] = ::RequestBid
        model
      end

      def payment(options,  params:, current_user:, **)
        params['payment'] == 'accepted'
        true
        # Todo: Try Getting Money from stripe
      end

      def order(options,  params:, model:, current_user:, **)
        order_params = {
          'customer_id' => current_user.id,
          'user_id' => model.user.id,
          'price' => model.price,
          'currency' => params['currency'],
          'status' => 'waiting_report',
          'bid_id' => model.id
        }
        result = ::V1::Order::CreateBidOrder.(order_params)
      end

      def finalize(options,  params:, model:, current_user:, **)
        model.status = 'accepted'
      end

    end
  end
end

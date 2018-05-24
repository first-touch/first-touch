module V1
  module Request
    class AcceptBid < FirstTouch::Operation
      step :validate_user_is_club
      failure :unauthenticated!, fail_fast: true
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :payment
      failure :process_payment_failure!, fail_fast: true
      step :order
      failure :model_not_found!, fail_fast: true
      step :finalize
      step Trailblazer::Operation::Contract::Build(
        constant: ::V1::RequestBid::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      private


      def validate_user_is_club(current_user:, **)
        # TODO: refactor once club are ready
        return true
        ### /TODO
        return false unless current_user.managed_clubs.include?(club_from_token)
      end

      def find_model!(options,  params:, current_user:, **)
        requestId = params[:request_id]
        bidId = params[:bid_id]
        # TODO: refactor once club are ready
        club = current_user
        ### /TODO
        request = club.requests.find(requestId)
        model = request.request_bids.find_by(id: bidId, status: 'pending')
        if model
          params['currency'] = request.price['currency']
        end
        options['model'] = model
        options['model.class'] = ::RequestBid
        options['model']
      end

      def payment(options,  params:, current_user:, **)
        params['payment'] == 'accepted'
        true
        # Todo: Try Getting Money from stripe
      end

      def order(options,  params:, model:, current_user:, **)
        order_params = {
          'customer_id' => current_user.id,
          'user' => model.user,
          'price' => model.price['value'],
          'currency' => params['currency'],
          'status' => 'pending_report',
          'request_bid_id' => model.id
        }
        result = ::V1::Order::CreateBidOrder.(order_params)
        result.success?
      end

      def finalize(options,  params:, model:, current_user:, **)
        model.status = 'accepted'
      end

    end
  end
end

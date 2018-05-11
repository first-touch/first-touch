require './lib/payment_util'

module V1
  module Request
    class AcceptBid < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :payment
      failure :stripe_failure!, fail_fast: true
      step :order
      failure :model_not_found!, fail_fast: true
      step :persist_stripe_transaction!
      step :finalize
      failure :refund
      step Trailblazer::Operation::Contract::Build(
        constant: ::V1::RequestBid::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      private

      def find_model!(options,  params:, current_user:, **)
        requestId = params[:request_id]
        bidId = params[:bid_id]
        if current_user.is_a?(::Club) || true
          request = current_user.requests.find(requestId)
          model = request.request_bids.find_by(id: bidId, status: 'pending')
          if model
            params['currency'] = request.price['currency']
          end
          options['model'] = model
          options['model.class'] = ::RequestBid
        end
        options['model']
      end

      def payment(options,  params:, current_user:, **)
        card_token = params[:token]
        bid = options['model']
        user = bid.user
        amount = bid.price['value'] * 100
        success = false
        charge = nil
        if amount == 0
          success = true
        elsif !card_token.nil?
          currency = bid.price['currency']
          if !amount.nil? and !currency.nil?
            params = {
              amount: amount,
              currency: currency,
              card_token: card_token,
              account: user.stripe_ft.stripe_id
            }
            charge = PaymentUtil.stripe_charge(params, current_user: current_user)
            if !charge.nil?
              options['stripe_charge_id'] = charge.id
              success = true
            end
          end
        end
        success
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

      def persist_stripe_transaction!(options, params:, model:,   **)
        stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_payout.log")
        transaction_params = {
          stripe_id: options['stripe_charge_id'],
          order: model.order,
          type_transaction: 'charge',
          payout: false
        }
        result = ::V1::StripeTransaction::Create.(transaction_params)
        if result.failure?
          stripe_logger.error("StripeTransaction creation failed for bid #{model.id}, charge_id: #{options['stripe_charge_id']}")
        end
        true
      end

      def finalize(options,  params:, model:, current_user:, **)
        model.status = 'accepted'
      end

      def refund(options,  params:, model:, current_user:, **)
        PaymentUtil.refund(options['stripe_charge_id'])
      end

    end
  end
end

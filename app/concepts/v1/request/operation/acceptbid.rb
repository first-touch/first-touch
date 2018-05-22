require './lib/payment_util'

module V1
  module Request
    class AcceptBid < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :save_card!
      failure :stripe_failure!, fail_fast: true
      step :payment
      failure :stripe_failure!, fail_fast: true
      step :order
      failure :model_not_found!
      step :persist_stripe_transaction!
      step :finalize
      step :unpublish
      step :init_report!
      failure :refund
      failure :delete_report!
      step Trailblazer::Operation::Contract::Build(
        constant: ::V1::RequestBid::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      private

      def init_report!(options, model:, params:, current_user:, **)
        request = model.request
        type_report = model.request.type_request == 'team' ? 'team' : 'player'
        report_params = {
          'user' => model.user,
          'type_report' => type_report,
          'request_id' => request.id,
          'price' => model.price,
          'status' => 'private',
          'completion_status' => 'pending'
        }
        result = ::V1::Report::Pending.(report_params, current_user: current_user)
        if result.success?
          report = result['model']
          order = model.order
          order.report = report
          order.save!
          model.report_id = report.id
        end
        result.success?
      end

      def delete_report!(options, model:, params:, current_user:, **)
        request = model.request
        report = ::Report.find_by user: model.user, request: request
        if !report.nil?
          report.delete
        end
      end

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

      def save_card!(options, params:, model:, current_user:,  **)
        save = params[:save]
        success = true
        if save
          if current_user.stripe_ft.nil?
            begin
              customer = ::Stripe::Customer.create({
                source: params['token'],
                email: current_user.email,
              })
            rescue => e
              options['stripe.errors'] = e
            end
            params['token'] = customer.default_source
            stripe_ft = ::StripeFt.new(
              stripe_id: customer.id,
              user: current_user
            )
            current_user.stripe_ft = stripe_ft
            current_user.save!
          else
            stripe_ft = current_user.stripe_ft
            begin
            customer = ::Stripe::Customer.retrieve(stripe_ft.stripe_id)
            source = customer.sources.create(source: params['token'])
            rescue => e
              options['stripe.errors'] = e
            end
            params['token'] = source
          end
        end
        success
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
            charge_params = {
              amount: amount,
              currency: currency,
              card_token: card_token,
              account: user.stripe_ft.stripe_id
            }
            if params[:save] == true or params[:usesaved]
              charge_params[:customer] = current_user.stripe_ft.stripe_id
            end
            begin
              charge = PaymentUtil.stripe_charge(charge_params, current_user: current_user)
            rescue => e
              options['stripe.errors'] = e
            end
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

      def unpublish(options,  params:, model:, current_user:, **)
        if params[:keep] == false
          request = model.request
          request.status = 'private'
          request.save
        end
        true
      end

      def refund(options,  params:, model:, current_user:, **)
        PaymentUtil.refund_charge(options['stripe_charge_id'])
      end

    end
  end
end

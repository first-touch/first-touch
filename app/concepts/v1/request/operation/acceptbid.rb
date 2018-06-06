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

      def init_report!(_options, model:, params:, current_user:, **)
        request = model.request
        type_report = model.request.type_request == 'team' ? 'team' : 'player'
        report_params = {
          'user' => model.user,
          'type_report' => type_report,
          'request_id' => request.id,
          'price' => model.price,
          'status' => 'private',
          'completion_status' => 'pending',
          'meta_data' => { conclusion: ''}
        }
        result = ::V1::Report::Pending.(report_params, current_user: current_user)
        puts result['contract.default'].to_json
        if result.success?
          report = result['model']
          order = model.order
          order.report = report
          order.save!
          model.report_id = report.id
        end
        result.success?
      end

      def delete_report!(model:, **)
        request = model.request
        report = ::Report.find_by user: model.user, request: request
        report&.delete
      end

      def find_model!(options, params:, current_club:, **)
        requestId = params[:request_id]
        bidId = params[:bid_id]
        if !current_club.nil?
          request = current_club.requests.find(requestId)
          model = request.request_bids.find_by(id: bidId, status: 'pending')
          params['currency'] = request.price['currency'] if model
          options['model'] = model
          options['model.class'] = ::RequestBid
        end
        options['model']
      end

      def save_card!(options, params:, model:, current_club:, **)
        save = params[:save]
        success = true
        if save
          if current_club.stripe_id.nil?
            begin
              customer = ::Stripe::Customer.create(
                source: params['token'],
                email: current_user.email
              )
            rescue StandardError => e
              options['stripe.errors'] = e
            end
            params['token'] = customer.default_source
            current_user.stripe_id = customer.id
            current_user.save!
          else
            begin
              customer = ::Stripe::Customer.retrieve(current_club.stripe_id)
              source = customer.sources.create(source: params['token'])
            rescue StandardError => e
              options['stripe.errors'] = e
            end
            params['token'] = source
          end
        end
        success
      end

      def payment(options, params:, current_club:, **)
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
          if !amount.nil? && !currency.nil?
            charge_params = {
              amount: amount,
              currency: currency,
              card_token: card_token,
              account: user.stripe_ft.stripe_id
            }
            if (params[:save] == true) || params[:usesaved]
              charge_params[:customer] = current_club.stripe_id
            end
            begin
              charge = PaymentUtil.stripe_charge(charge_params, current_club: current_club)
            rescue StandardError => e
              options['stripe.errors'] = e
            end
            unless charge.nil?
              options['stripe_charge_id'] = charge.id
              success = true
            end
          end
        end
        success
      end

      def order(_options, params:, model:, current_club:, **)
        order_params = {
          'customer_id' => current_club.id,
          'user' => model.user,
          'price' => model.price['value'],
          'currency' => params['currency'],
          'status' => 'pending_report',
          'request_bid_id' => model.id
        }
        result = ::V1::Order::CreateBidOrder.(order_params)
        result.success?
      end

      def persist_stripe_transaction!(options, params:, model:, **)
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

      def finalize(model:, **)
        model.status = 'accepted'
      end

      def unpublish(params:, model:, **)
        if params[:keep] == false
          request = model.request
          request.status = 'private'
          request.save
        end
        true
      end

      def refund(**)
        PaymentUtil.refund_charge(options['stripe_charge_id'])
      end
    end
  end
end

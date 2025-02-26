require './lib/payment_util'

module V1
  module Report
    class Buy < FirstTouch::Operation
      step Model(::Order, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :find_report!
      failure :model_not_found!, fail_fast: true
      step :setup_model!
      step :save_card!
      failure :stripe_failure!, fail_fast: true
      step :dest_has_stripe!
      failure :stripe_failure!, fail_fast: true
      step :made_payment!
      failure :stripe_failure!, fail_fast: true
      step :complete_order!
      step Trailblazer::Operation::Contract::Build(
        constant: Order::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :persist_stripe_transaction!

      def find_report!(options, params:, **)
        options[:model].report = ::Report.find_by("(price->>'value')::int > 0 and id = ?", params[:order]['report_id'])
        options['model.class'] = ::Order
        !options[:model].report.nil?
      end

      def setup_model!(options, current_club:, **)
        options[:model].customer_id = current_club.id
        options[:model].report = options[:model].report
        options[:model].price = options[:model].report.price['value']
        options[:model].user = options[:model].report.user
      end

      def dest_has_stripe!(options, params:, **)
        stripe_ft = options[:model].user.stripe_ft
        if stripe_ft.nil? || stripe_ft.preferred_account.nil?
          options['stripe.errors'] = I18n.t 'stripe.scout_stripe_not_found'
        end
        stripe_ft.nil? ? false : stripe_ft.stripe_id
      end

      def made_payment!(options, params:, current_club:, **)
        card_token = params[:token]
        report = options[:model].report
        user = report.user
        amount = report.price['value'] * 100
        success = false
        charge = nil
        if amount == 0
          success = true
        elsif !card_token.nil?
          currency = report.price['currency']
          if !amount.nil? && !currency.nil?
            charge_params = {
              amount: amount,
              currency: currency,
              card_token: card_token,
              account: user.stripe_ft.stripe_id
            }
            if (params[:save] == true) || (params[:usesaved] == true)
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

      def save_card!(options, params:, current_club:, **)
        save = params[:save]
        success = true
        if save
          if current_club.stripe_id.nil?
            begin
              customer = ::Stripe::Customer.create(
                source: params['token']
              )
            rescue StandardError => e
              options['stripe.errors'] = e
            end
            params['token'] = customer.default_source
            current_club.stripe_id = customer.id
            current_club.save!
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

      def complete_order!(options, **)
        options[:model].status = 'completed'
        options[:model].completed_date = Time.now
        true
      end

      def authorized!(current_club:, **)
        !current_club.nil?
      end

      def persist_stripe_transaction!(options, params:, **)
        stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_payout.log")
        transaction_params = {
          stripe_id: options['stripe_charge_id'],
          order: model,
          type_transaction: 'charge',
          payout: false
        }
        result = ::V1::StripeTransaction::Create.(params: transaction_params)
        if result.success?
          stripe_transaction = result[:model]
          ::StripePayoutJob.set(wait: Rails.configuration.stripe[:payout_schedule]).perform_later stripe_transaction.id
        else
          stripe_logger.error("StripeTransaction creation failed, Payout had not be schedule, charge_id: #{options['stripe_charge_id']}")
        end
        true
      end
    end
  end
end

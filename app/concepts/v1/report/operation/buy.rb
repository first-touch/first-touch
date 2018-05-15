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
        options['model'].report = ::Report.find_by("(price->>'value')::int > 0 and id = ?", params[:order]['report_id'])
        options['model.class'] = ::Order
        !options['model'].report.nil?
      end

      def setup_model!(options, model:, current_user:, **)
        model.customer_id = current_user.id
        model.report =  options['model'].report
        model.price = model.report.price['value']
        model.user = model.report.user
      end

      def dest_has_stripe!(options, params:, model:,   **)
        stripe_ft = model.user.stripe_ft
        if stripe_ft.nil? or stripe_ft.stripe_id.nil?
          options['stripe.errors'] = ['scout_stripe_not_found']
        end
        (stripe_ft.nil?) ? false: stripe_ft.stripe_id
      end

      def made_payment!(options, params:, model:, current_user:,  **)
        card_token = params[:token]
        report = options['model'].report
        user = report.user
        amount = report.price['value'] * 100
        success = false
        charge = nil
        if amount == 0
          success = true
        elsif !card_token.nil?
          currency = report.price['currency']
          if !amount.nil? and !currency.nil?
            charge_params = {
              amount: amount,
              currency: currency,
              card_token: card_token,
              account: user.stripe_ft.stripe_id,
            }
            if params[:save] == true and !current_user.stripe_ft.nil?
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

      def complete_order!(model: ,  **)
        model.status = "completed"
        true
      end

      def authorized!(current_user:, **)
        current_user.is_a?(::Club) || true
      end

      def persist_stripe_transaction!(options, params:, model:,   **)
        stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_payout.log")
        transaction_params = {
          stripe_id: options['stripe_charge_id'],
          order: model,
          type_transaction: 'charge',
          payout: false
        }
        result = ::V1::StripeTransaction::Create.(transaction_params)
        if result.success?
          stripe_transaction = result['model']
          ::StripePayoutJob.set(wait: Rails.configuration.stripe[:payout_schedule]).perform_later stripe_transaction.id
        else
          stripe_logger.error("StripeTransaction creation failed, Payout had not be schedule, charge_id: #{options['stripe_charge_id']}")
        end
        true
      end

    end
  end
end

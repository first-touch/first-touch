module V1
  module Report
    class Buy < FirstTouch::Operation
      step Model(::Order, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :find_report!
      failure :model_not_found!, fail_fast: true
      step :find_report!
      failure :model_not_found!, fail_fast: true
      step :setup_model!
      step :dest_has_stripe!
      failure :stripe_failure!, fail_fast: true
      step :made_payment!
      failure :stripe_failure!, fail_fast: true
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
          ft_fees = (Rails.configuration.stripe[:fees].nil?) ? 0.05: Rails.configuration.stripe[:fees]
          fees = (amount * ft_fees).round
          if !amount.nil? and !currency.nil?
            stripe_logger = ::Logger.new("#{Rails.root}/log/stripe.log")
            begin
              charge = ::Stripe::Charge.create({
                :amount => amount - fees,
                :currency => currency,
                :source => card_token,
                :application_fee => fees,
                :destination => {
                  :account => user.stripe_ft.stripe_id,
                }
              })
            rescue => e
              stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_error.log")
              body = e.json_body
              err = body[:error]
              stripe_logger.warn("Charge has been refused for user #{current_user.id} : #{err[:message]}")
              options['stripe.errors'] = [err[:message]]
            end
            if !charge.nil?
              stripe_logger.info("Succefully charge for report_id #{report.id} by user #{current_user.id} amount of #{amount} #{currency} stripe_id: #{charge.id}")
              options['stripe_charge_id'] = charge.id
              success = true
            end
          end
        end
        if success
          model.status = "completed"
        end
        success
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

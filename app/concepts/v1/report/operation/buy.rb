module V1
  module Report
    class Buy < FirstTouch::Operation
      step Model(::Order, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
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


      def find_report!(options, params:, **)
        options['model'].report = ::Report.find(params[:order]['report_id'])
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
        model.user.stripe_ft.stripe_id
      end
      # Todo: Wait for stripe integration
      def made_payment!(options, params:, model:,   **)
        card_token = params[:token]
        report = options['model'].report
        user = report.user
        amount = report.price['value']
        success = false
        if amount == 0
          success = true
        elsif !card_token.nil?
          currency = report.price['currency']
          fees = (amount * 0.05).round
          if !amount.nil? and !currency.nil?
            begin
              charge = ::Stripe::Charge.create({
                :amount => amount,
                :currency => currency,
                :source => card_token,
                :application_fee => fees,
                :destination => {
                  :account => user.stripe_ft.stripe_id,
                }
              })
            rescue => e
              body = e.json_body
              err = body[:error]
              options['stripe.errors'] = [err[:message]]
            end
            if charge
              stripe_ft = user.stripe_ft
              begin
                payout = ::Stripe::Payout.create({
                  :amount => charge.amount - fees,
                  :currency => currency,
                  :destination => !(stripe_ft.preferred_account.nil?) ? stripe_ft.preferred_account: nil
                }, {:stripe_account => stripe_ft.stripe_id})
                rescue => e
                  body = e.json_body
                  puts body.to_json
                end
              success = true
              #TODO Create stripe Transaction model
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

    end
  end
end

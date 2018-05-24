module V1
  module Order
    class SendMoney < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :setup_model!
      step :pay_scout!
      failure :stripe_payment_failure!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Order::Contract::SendMoney
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_model!(options, params:, user_id:, **)
        options['model.class'] = ::Order
        options['model'] = ::Order.find_by request_bid_id: params['bid_id'], user_id: user_id, status: 'pending_report'
      end

      def setup_model!(options, params:, user_id:, **)
        model = options['model']
        model.status = 'completed'
        model.completed_date = Time.now
        model.report = ::Report.find(params["report_id"])
        options['model'] = model
        model.report
      end

      def pay_scout!(options, params:, user_id:, **)
        model = options['model']

        stripe_transaction = model.stripe_transactions.find_by(type_transaction: 'charge')
        if !stripe_transaction.nil?
          ::StripePayoutJob.set(wait: Rails.configuration.stripe[:payout_schedule]).perform_later stripe_transaction.id
        else
          stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_payout.log")
          stripe_logger.error("StripeTransaction charge not found for order : #{model.id}, payout has not be scheduled")
        end
      end
    end
  end
end

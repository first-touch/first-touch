module V1
  module Order
    class SendMoney < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :pay_scout!
      failure :stripe_payment_failure!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: Order::Contract::SendMoney
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_model!(options, params:, user_id:, **)
        puts params.to_json
        options['model.class'] = ::Order
        options['model'] = ::Order.find_by request_bid_id: params['bid_id'], user_id: user_id, status: 'pending_report'
      end

      def pay_scout!(options, params:, user_id:, **)
        # TODO: Make stripe payment
        success = true;
        puts params.to_json
        if success
          model = options['model']
          model.status = 'completed'
          model.report = ::Report.find(params["report_id"])
          options['model'] = model
        end
        success
      end
    end
  end
end

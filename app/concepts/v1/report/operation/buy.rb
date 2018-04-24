module V1
  module Report
    class Buy < Trailblazer::Operation
      step Model(::Order, :new)
      step :authorized!
      failure :unauthenticated, fail_fast: true
      step :find_report!
      failure :model_not_found!, fail_fast: true
      step :made_payment!
      failure :process_payment_failure!, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Order::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()


      def find_report!(options, params:, **)
        options['model'].report = ::Report.find(params[:order]['report_id'])
        options['model.class'] = ::Order
      end


      def setup_model!(options, model:, current_user:, **)
        model.customer_id = current_user.id
        model.price = model.report.price['value']
        model.user = model.report.user
      end

      # Todo: Wait for stripe integration
      def made_payment!(model:, current_user:, **)
        model.status = "completed"
        true
      end

      def authorized!(current_user:, **)
        current_user.is_a?(::Club) || true
      end

    end
  end
end

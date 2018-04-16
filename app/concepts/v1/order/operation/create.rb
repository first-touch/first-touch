module V1
  module Order
    class Create < Trailblazer::Operation
      step Model(::Order, :new)
      step :find_report!
      failure :model_not_found, fail_fast: true
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Order::Contract::Create
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_report!(options, params:, **)
        options['report'] = ::Report.find(params[:report_id])
        options['model.class'] = ::Report
      end

      def setup_model!(model:, current_user:, status:, **)
        report = options['report']
        model.customer_id = current_user.id
        model.status = status
        model.price = report.price
        model.user = report.user
        model.report = report
      end
    end
  end
end

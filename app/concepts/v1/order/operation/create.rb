module V1
  module Order
    class Create < Trailblazer::Operation
      step Model(::Order, :new)
      step :setup_model!
      step Trailblazer::Operation::Contract::Build( constant: Order::Contract::Create )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(model:, params:, current_user:, status:, **)
        report = (params[:report_id].blank?) ? nil : ::Report.find(params[:report_id])
        if report.blank?
          false
        else
          model.customer_id = current_user.id
          model.status = status
          model.price = report.price
          model.user = report.user
          model.report = report
          true
        end
      end
    end
  end
end

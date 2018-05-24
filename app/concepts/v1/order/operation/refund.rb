module V1
  module Order
    class Refund < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :send_mail!
      step :setup_model!
      step Trailblazer::Operation::Contract::Build(
        constant: Order::Contract::SendMoney
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def find_model!(options, params:, current_user:, **)
        options['model.class'] = ::Order
        options['model'] = model = ::Order.find_by report_id: params['report_id'], customer_id: current_user.id, status: ['pending_report','completed'], refund_status: nil
        options['result.model'] = result = Result.new(!model.nil?, {})
        result.success?
      end

      def send_mail!(model:, current_user:, **)
        begin
          ::SystemMailer.notify('refund', model, current_user.id)
        rescue => e
          stripe_logger = ::Logger.new("#{Rails.root}/log/mailer.log")
          stripe_logger.error("ReportCanceled An error occured when sending email to club #{e.to_s}")
        end
        true
      end

      def setup_model!(model:, current_user:, **)
        model.refund_status = 'asked'
      end

    end
  end
end

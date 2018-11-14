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

      def find_model!(options, params:,  **)
        options['model.class'] = ::Order
        options[:model] = model = ::Order.find_by report_id: params['report_id'], customer_id: options[:current_user].id, status: %w[pending_report completed], refund_status: nil
        options['result.model'] = result = Result.new(!model.nil?, {})
        result.success?
      end

      def send_mail!(options, **)
        begin
          ::SystemMailer.notify('refund', model, options[:current_user].id)
        rescue StandardError => e
          stripe_logger = ::Logger.new("#{Rails.root}/log/mailer.log")
          stripe_logger.error("ReportCanceled An error occured when sending email to club #{e}")
        end
        true
      end

      def setup_model!(options, **)
        options[:model].refund_status = 'asked'
      end
    end
  end
end

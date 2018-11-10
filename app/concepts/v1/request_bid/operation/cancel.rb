require './lib/payment_util'

module V1
  module RequestBid
    class Cancel < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: RequestBid::Contract::Cancel
      )
      step :find_report!
      step :refund!
      failure :stripe_failure!, fail_fast: true
      step :cancel!
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :persist_files!
      step :notify!
      step :position!

      private

      def find_model!(options, params:,  **)
        options['model.class'] = ::RequestBid
        options[:model] = model = options[:current_user].request_bids.find_by(request_id: params[:id], status: %w[accepted joblist])
        options['result.model'] = result = Result.new(!options[:model].nil?, {})
        result.success?
      end

      def find_report!(options, params:,  **)
        success = true
        if options[:model].request.type_request != 'position'
          report = options[:model].order.report
          options['report'] = report
          success = true if report.nil?
        end
        success
      end

      def refund!(options,  **)
        result = true
        if options[:model].request.type_request != 'position'
          transaction = options[:model].order.stripe_transactions.find_by(type_transaction: 'charge')
          refund = PaymentUtil.refund_charge(transaction.stripe_id, options[:model].id)
          if refund
            transaction_params = {
              stripe_id: refund.id,
              order: options[:model].order,
              type_transaction: 'refund',
              payout: nil
            }
            result = ::V1::StripeTransaction::Create.(params: transaction_params)
          else
            options['stripe.errors'] = I18n.t 'stripe.charge_not_found'
            result = false
          end
        end
        result
      end

      def cancel!(options, **)
        if options[:model].request.type_request != 'position'
          options[:model].status = 'canceled'
          report = options['report']
          report.status = 'deleted'
          report.save!
          order = options[:model].order
          order.status = 'canceled'
          order.save!
        end
        true
      end

      def notify!(options, **)
        if options[:model].request.type_request != 'position'
          begin
            ::SystemMailer.notify('cancelation', model, model.request.user.id)
          rescue StandardError => e
            stripe_logger = ::Logger.new("#{Rails.root}/log/mailer.log")
            stripe_logger.error("ReportCanceled An error occured when sending email to club #{e}")
          end
        end
        true
      end

      def persist_files!(options, params:,  **)
        params[:files].each do |file|
          file_params = { url: file[:url], filename: file[:filename], request_bid: model }
          result = ::V1::Attachment::Create.(params: file_params, current_user: options[:current_user])
        end
        true
      end

      def position!(_options, **)
        options[:model].destroy if options[:model].request.type_request == 'position'
        true
      end
    end
  end
end

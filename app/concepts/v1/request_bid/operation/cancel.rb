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
      step :position!

      private
      def find_model!(options, params:, current_user:, **)
        options['model.class'] = ::RequestBid
        options['model'] = model = current_user.request_bids.find_by(request_id: params[:id], status: ['accepted', 'joblist'])
        options['result.model'] = result = Result.new(!model.nil?, {})
        result.success?
      end

      def find_report!(options, params:, model:, current_user:, **)
        success = true
        if model.request.type_request != 'position'
          report = model.order.report
          options['report'] = report
          if report.nil?
            success = true
          end
        end
        success
      end

      def refund!(options, model:, current_user:, **)
        result = true
        if model.request.type_request != 'position'
          transaction = model.order.stripe_transactions.find_by(type_transaction: 'charge')
          refund = PaymentUtil.refund_charge(transaction.stripe_id, model.id)
          if refund
            transaction_params = {
              stripe_id: refund.id,
              order: model.order,
              type_transaction: 'refund',
              payout: nil
            }
            result = ::V1::StripeTransaction::Create.(transaction_params)
          else
            options['stripe.errors'] =  I18n.t 'stripe.charge_not_found'
            result = false
          end
        end
        result
      end

      def cancel!(options, model:, **)
        if model.request.type_request != 'position'
          model.status = 'canceled'
          report = options['report']
          report.status = 'deleted'
          report.save!
          order = model.order
          order.status = 'canceled'
          order.save!
        end
        true
      end

      def position!(options, model:, **)
        if model.request.type_request == 'position'
          model.destroy
        end
        true
      end

    end
  end
end

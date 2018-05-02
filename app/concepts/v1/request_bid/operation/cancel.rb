module V1
  module RequestBid
    class Cancel < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: RequestBid::Contract::Cancel
      )
      step :refund!
      step :cancel!
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private
      def find_model!(options, params:, current_user:, **)
        options['model.class'] = ::RequestBid
        options['model'] = model = current_user.request_bids.find_by(request_id: params[:id], status: 'accepted')
        options['result.model'] = result = Result.new(!model.nil?, {})
        result.success?
      end

      def refund!(options, params:, current_user:, **)
        model = options['model']
        if model.request.type_request != 'position'
          # TODO: Refund Payment Stripe
          true
        else
          true
        end
      end

      def cancel!(options, params:, current_user:, **)
        model = options['model']
        model.status = 'canceled'
      end

    end
  end
end

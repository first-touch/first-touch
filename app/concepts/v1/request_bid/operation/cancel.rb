module V1
  module RequestBid
    class Cancel < FirstTouch::Operation
      step :find_model!
      failure :model_not_found!, fail_fast: true
      step :refund!
      step :cancel!

      private
      def find_model!(options, params:, current_user:, **)
        options['model.class'] = ::RequestBid
        options['model'] = current_user.request_bids.find_by(id: params[:id], status: 'accepted')
        !options['model'].blank?
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
        model.status = 'cancel'
        model.save!
      end

    end
  end
end

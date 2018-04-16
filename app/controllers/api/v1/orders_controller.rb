require './lib/payment_util'

module Api
  module V1
    class OrdersController < Api::V1::BaseController
      # @Todo will change once stripe is set
      def create
        payment = PaymentUtil.made_payment(order_params)
        if payment
          result = ::V1::Order::Create.(params,
                                        current_user: current_user, status: payment[:status])
          return render json: { success: true }, status: :ok if result.success?
        end
        render json: { success: false,
                       errors: ['Please check again your payment information'] }, status: :bad_request
      end

      def order_params
        params.require(:order).permit(:report_id, :payment_method)
      end
    end
  end
end

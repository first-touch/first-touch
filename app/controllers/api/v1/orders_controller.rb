require './lib/payment_util'

module Api
  module V1
    class OrdersController < Api::V1::BaseController
      def create
        payment = PaymentUtil.made_payment(order_params)
        if payment
          result = ::V1::Order::Create.(order_params,current_user: current_user,status: payment[:status])
          if result.success?
            render json: {success: true}, status: :ok
          else
            errors = (result['contract.default'].blank?) ? ['sometings is wrong with your request']: result['contract.default'].errors.full_messages
            render json: {success: false, errors: errors }, status: :bad_request
          end
        else
          render json: {success: false, errors: ['Please check again your payment information'] }, status: :bad_request
        end
      end

      def order_params
        params.require(:order).permit(:report_id, :payment_method)
      end
    end
  end
end

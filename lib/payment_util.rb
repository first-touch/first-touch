class PaymentUtil
  class << self
    def stripe_charge(params, current_user:)
      stripe_logger = ::Logger.new("#{Rails.root}/log/stripe.log")
      ft_fees = (Rails.configuration.stripe[:fees].nil?) ? 0.05: Rails.configuration.stripe[:fees]
      fees = (params[:amount] * ft_fees).round
      amount = params[:amount] - fees
      charge = nil
      errors = nil
      begin
        charge_params = {
          :amount => params[:amount] - fees,
          :currency => params[:currency],
          :source => params[:card_token],
          :application_fee => fees,
          :destination => {
            :account => params[:account],
          }
        }
        if !params[:customer].nil?
          charge_params['customer'] = params[:customer]
        end
        charge = ::Stripe::Charge.create(charge_params)
      rescue => e
        stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_error.log")
        body = e.json_body
        err = body[:error]
        stripe_logger.warn("Charge has been refused for user #{current_user.id} with customer id given ? #{!charge_params['customer'].nil?}: #{err[:message]}")
        raise e
      end
      if charge
        stripe_logger.info("Succefully charge by user #{current_user.id} amount of #{amount} #{params[:currency]} stripe_id: #{charge.id}")
      end
      charge
    end

    def refund_charge(charge_id, bid_id = nil)
      stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_refund.log")
      stripe_logger.info('StripeRefund: Try to refund charge_id : #{charge_id}')
      refund = nil
      begin
        charge = Stripe::Charge.retrieve(charge_id)
        refund = Stripe::Refund.create({
          charge: charge_id,
          amount: charge.amount,
        })
        stripe_logger.info('StripeRefund: Charge id : #{charge_id} succefuly refunded ! ')
      rescue => e
        body = e.json_body
        stripe_logger.error("StripeRefund: Can not refund charge with stripe id #{charge_id} for bid id = #{bid_id} stripe_error: #{body}")
      end
      refund
    end
  end
end

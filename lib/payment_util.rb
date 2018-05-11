class PaymentUtil
  class << self
    def stripe_charge(params, current_user:)
      stripe_logger = ::Logger.new("#{Rails.root}/log/stripe.log")
      ft_fees = (Rails.configuration.stripe[:fees].nil?) ? 0.05: Rails.configuration.stripe[:fees]
      fees = (params[:amount] * ft_fees).round
      amount = params[:amount] - fees
      charge = nil
      begin
        charge = ::Stripe::Charge.create({
          :amount => params[:amount] - fees,
          :currency => params[:currency],
          :source => params[:card_token],
          :application_fee => fees,
          :destination => {
            :account => params[:account],
          }
        })
        puts charge
      rescue => e
        stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_error.log")
        body = e.json_body
        err = body[:error]
        stripe_logger.warn("Charge has been refused for user #{current_user.id} : #{err[:message]}")
        options['stripe.errors'] = [err[:message]]
      end
      if charge
        stripe_logger.info("Succefully charge by user #{current_user.id} amount of #{amount} #{params[:currency]} stripe_id: #{charge.id}")
      end
      charge
    end

    def refund_charge(charge_id)
      stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_refund.log")
      stripe_logger.info('StripeRefund: Try to refund charge_id : #{charge_id}')
      charge = Stripe::Charge.retrieve(charge_id)
      if !charge.nil?
        begin
          refund = Stripe::Refund.create({
            charge: charge_id,
            amount: charge.amount,
          })
        rescue => e
          stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_payout.log")
          body = e.json_body
          stripe_logger.error("StripePayoutJob: Can not payout the scout #{body}")
        end
      else
        stripe_logger.error("StripeRefund: Charge with stripe id #{charge_id} not found")
      end
      true
    end
  end
end

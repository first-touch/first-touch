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
        puts charge
      rescue => e
        stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_error.log")
        body = e.json_body
        err = body[:error]
        stripe_logger.warn("Charge has been refused for user #{current_user.id} : #{err[:message]}")
        errors = [err[:message]]
      end
      if charge
        stripe_logger.info("Succefully charge by user #{current_user.id} amount of #{amount} #{params[:currency]} stripe_id: #{charge.id}")
      end
      charge
    end
  end
end

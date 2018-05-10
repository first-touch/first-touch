class StripePayoutJob < ApplicationJob
  queue_as :default

  def perform(charge_id)
    stripe_transaction = ::StripeTransaction.find_by(payout: false, id: charge_id)
    if !stripe_transaction.nil?
      charge = Stripe::Charge.retrieve(stripe_transaction.stripe_id)
      user_stripe_ft = stripe_transaction.order.user.stripe_ft
      begin
        payout = ::Stripe::Payout.create({
          :amount => charge.amount,
          :currency => charge.currency,
          :destination => !(user_stripe_ft.preferred_account.nil?) ? user_stripe_ft.preferred_account: nil
        }, {:stripe_account => user_stripe_ft.stripe_id})
        if !payout.nil?
          stripe_transaction.payout = true
          stripe_transaction.save!
        end
      rescue => e
        stripe_logger = ::Logger.new("#{Rails.root}/log/stripe_payout.log")
        body = e.json_body
        stripe_logger.error("StripePayoutJob: Can not payout the scout #{body}")
      end
    end
  end
end

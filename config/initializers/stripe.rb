Rails.configuration.stripe = {
  publishable_key: Rails.application.secrets.stripe[:publishable_key],
  secret_key: Rails.application.secrets.stripe[:secret_key],
  fees: 0.05,
  payout_schedule: 1.week
}

::Stripe.api_key = Rails.application.secrets.stripe[:secret_key]

module FirstTouch
  class Operation < Trailblazer::Operation
    step Policy::Guard(:authenticate!, name: :authenticate)
    failure :unauthenticated!, fail_fast: true

    private

    def authenticate!(current_user:, **)
      current_user.present?
    end

    def unauthenticated!(options, **)
      options['result.policy.failure'] = :unauthenticated
    end

    def model_not_found!(options, **)
      model_name = options['model.class'].name.titlecase
      error_message = I18n.t('models.not_found', model: model_name)
      options['result.model.errors'] = [error_message]
    end

    def stripe_failure!(options, **)
      stripe_error = options['stripe.errors']
      if stripe_error.is_a?(::Stripe::StripeError)
        body = stripe_error.json_body
        err  = body[:error]
        options['stripe.errors'] = err[:message]
      end
    end

  end
end

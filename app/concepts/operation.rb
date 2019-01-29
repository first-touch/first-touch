module FirstTouch
  class BaseOperation < Trailblazer::Operation
    def model_not_found!(options, **)
      model_name = options['model.class'].name.titlecase
      error_message = I18n.t('models.not_found', model: model_name, id: options[:id])
      options['result.model.errors'] = [error_message]
    end

    def unauthenticated!(options, **)
      options['result.policy.failure'] = :unauthenticated
    end

    def stripe_failure!(options, **)
      stripe_error = options['stripe.errors']
      return unless stripe_error.is_a?(::Stripe::StripeError)
      body = stripe_error.json_body
      err  = body[:error]
      options['stripe.errors'] = err[:message]
    end
  end

  class NoAuthOperation < BaseOperation
  end

  class Operation < BaseOperation
    step Policy::Guard(:authenticate!, name: :authenticate)
    failure :unauthenticated!, fail_fast: true

    def unauthorized!(options, **)
      options['result.policy.failure'] = :unauthorized
    end

    def authenticate!(options, **)
      options[:current_user].present?
    end
  end

  class ClubOperation < Operation
    def authenticate!(options, **)
      super
      return false unless options[:current_club].present?
      performed_by_club_admin?(options[:current_user], options[:current_club])
    end

    private

    def performed_by_club_admin?(user, club)
      user.managed_clubs.include?(club)
    end
  end
end

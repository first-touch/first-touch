module FirstTouch
  class BaseOperation < Trailblazer::Operation
    def model_not_found!(options, **)
      model_name = options['model.class'].name.titlecase
      error_message = I18n.t('models.not_found', model: model_name)
      options['result.model.errors'] = [error_message]
    end
  end

  class NoAuthOperation < BaseOperation
  end

  class Operation < BaseOperation
    step Policy::Guard(:authenticate!, name: :authenticate)
    failure :unauthenticated!, fail_fast: true

    def authenticate!(current_user:, **)
      current_user.present?
    end

    def unauthenticated!(options, **)
      options['result.policy.failure'] = :unauthenticated
    end

    def unauthorized!(options, **)
      options['result.policy.failure'] = :unauthorized
    end

    def stripe_failure!(options, **)
      error_message = options['stripe.errors']
      options['result.model.errors'] = [error_message]
    end

  end
end

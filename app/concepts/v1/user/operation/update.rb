module V1
  module User
    class Update < FirstTouch::Operation
      step Model(::User, :find_by)
      failure :model_not_found!, fail_fast: true
      step Policy::Guard(:authorize!, name: :authorize)
      failure :unauthorized!, fail_fast: true
      step Trailblazer::Operation::Contract::Build(
        constant: User::Contract::Update
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()
      step :update_avatar!

      private

      def update_avatar!(_options, params:, model:, **)
        return true unless params['avatar']
        personal_profile = model.personal_profile
        personal_profile.avatar.purge if personal_profile.avatar.attached?
        model.personal_profile.avatar.attach(params['avatar'])
        true
      end

      def missing_profile!(options, **)
        options[:errors] = I18n.t('user.no_profile')
      end

      def authorize!(_options, model:, current_user:, **)
        model&.id == current_user.id
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end
    end
  end
end

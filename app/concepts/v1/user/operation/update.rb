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

      private

      def authorize!(options, **)
        model && model == options[:current_user]
      end

      def unauthorized!(options, **)
        options['result.policy.failure'] = :unauthorized
      end
    end
  end
end

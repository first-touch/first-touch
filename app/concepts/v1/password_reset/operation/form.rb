module V1
  module PasswordReset
    class Form < Trailblazer::Operation
      step :setup_model
      step Trailblazer::Operation::Contract::Build(
        constant: PasswordReset::Contract::Form
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      def setup_model!(options, params:, **)
        options['model'].token = params['token']
        options['model.user'] = ::User.find_by(
          ::PasswordReminder.find_by_token(params['token'])[:user_id])
      end
    end
  end
end

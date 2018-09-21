module V1
  module User
    class UpdatePassword < Trailblazer::Operation
      step Policy::Guard(:validate_token!, name: :check_token)
      failure :missing_auth_token, fail_fast: true
      step :find_user!
      step Trailblazer::Operation::Contract::Build(
        constant: User::Contract::Register
      )
      step Trailblazer::Operation::Contract::Validate()
      step Trailblazer::Operation::Contract::Persist()

      private

      def validate_token!(options, **)
        http_headers = ActionDispatch::Http::Headers.from_hash(options[:headers])
        return false if http_headers['ResetToken']&.blank?
        token = http_headers['ResetToken']&.split(' ')&.last
        options['reset_token'] = token
      end

      def missing_auth_token(options)
        options['errors'] = 'missing token'
      end

      def find_user!(options, **)
        options['model'] = ::User.with_reset_password_token(options['reset_token'])
      end
    end
  end
end

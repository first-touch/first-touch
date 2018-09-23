module V1
  module User
    class UpdatePassword < FirstTouch::NoAuthOperation
      step Policy::Guard(:validate_token!, name: :check_token)
      failure :missing_auth_token, fail_fast: true
      step :find_user!
      failure :unauthenticated!, fail_fast: true
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
        options['errors'] = I18n.t('auth.missing_token')
      end

      def unauthenticated!(options)
        super
        options['errors'] = I18n.t('auth.invalid_reset_token')
      end

      def find_user!(options, **)
        options['model'] = ::User.with_reset_password_token(options['reset_token'])
        !options['model'].nil?
      end
    end
  end
end
